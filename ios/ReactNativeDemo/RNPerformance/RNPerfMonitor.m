//
//  RNPerfMonitor.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/7.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "RNPerfMonitor.h"

#import <React/RCTBridge.h>
#import <React/RCTBridge+Private.h>
#import <React/RCTUIManager.h>
#import <React/RCTPerformanceLogger.h>
#import <mach/mach.h>

#import "RNFPSUtils.h"

static vm_size_t RCTGetResidentMemorySize(void)
{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if (kerr != KERN_SUCCESS) {
        return 0;
    }
    
    return info.resident_size;
}

@implementation RNPerfMonitor
{
    CADisplayLink   *_uiDisplayLink;
    CADisplayLink   *_jsDisplayLink;
    RNFPSUtils      *_uiFPSGraph;
    RNFPSUtils      *_jsFPSGraph;
    RCTBridge       *_bridge;
    NSTimeInterval  _uiFPS;
    NSTimeInterval  _jsFPS;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _uiFPSGraph = [[RNFPSUtils alloc] init];
        _jsFPSGraph = [[RNFPSUtils alloc] init];
    }
    return self;
}

- (void)startMonitorWithBrige:(RCTBridge *)brigde
{
    _bridge = brigde;
    
    _uiDisplayLink = [CADisplayLink displayLinkWithTarget:self
                                                 selector:@selector(threadUpdate:)];
    [_uiDisplayLink addToRunLoop:[NSRunLoop mainRunLoop]
                         forMode:NSRunLoopCommonModes];
    
    [_bridge.batchedBridge dispatchBlock:^{
        self->_jsDisplayLink = [CADisplayLink displayLinkWithTarget:self
                                                           selector:@selector(threadUpdate:)];
        [self->_jsDisplayLink addToRunLoop:[NSRunLoop currentRunLoop]
                                   forMode:NSRunLoopCommonModes];
    } queue:RCTJSThread];
}

- (void)stopMonitor
{
    [_uiDisplayLink invalidate];
    [_jsDisplayLink invalidate];
    
    _uiDisplayLink = _jsDisplayLink = nil;
    _bridge = nil;
}

- (void)threadUpdate:(CADisplayLink *)displayLink
{
    if (displayLink == _jsDisplayLink) {
        [_jsFPSGraph onTick:displayLink.timestamp];
        _jsFPS = _jsFPSGraph.FPS;
        
    }
    else {
        [_uiFPSGraph onTick:displayLink.timestamp];
        _uiFPS = _uiFPSGraph.FPS;
        
        NSLog(@"%@",[self performanceInfo]);
    }
}

- (NSDictionary *)performanceInfo
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters addEntriesFromDictionary:[self performanceInfoWithoutFPSWithBridge:_bridge]];
    
    parameters[@"uiFPS"] = @(_uiFPS);
    parameters[@"jsFPS"] = @(_jsFPS);
    
    return parameters;
}

- (NSDictionary *)performanceInfoWithoutFPSWithBridge:(RCTBridge *)bridge
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    double mem = (double)RCTGetResidentMemorySize() / 1024 / 1024;
    parameters[@"RAM"] = [NSString stringWithFormat:@"%.2lfM",mem];
    
    NSDictionary<NSNumber *, UIView *> *views = [_bridge.uiManager valueForKey:@"viewRegistry"];
    NSUInteger viewCount = views.count;
    NSUInteger visibleViewCount = 0;
    for (UIView *view in views.allValues) {
        if (view.window || view.superview.window) {
            visibleViewCount++;
        }
    }
    
    parameters[@"viewCount"] = @(viewCount);
    parameters[@"visibleViewCount"] = @(visibleViewCount);
    
    [parameters addEntriesFromDictionary:[self performanceLoggerData:bridge]];
    
    return parameters;
}

- (NSDictionary *)performanceLoggerData:(RCTBridge *)bridge
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    NSUInteger i = 0;
    RCTPerformanceLogger *performanceLogger = [bridge performanceLogger];
    NSArray<NSNumber *> *values = [performanceLogger valuesForTags];
    for (NSString *label in [performanceLogger labelsForTags]) {
        long long value = values[i+1].longLongValue - values[i].longLongValue;
        NSString *unit = @"ms";
        if ([label hasSuffix:@"Size"]) {
            unit = @"b";
        } else if ([label hasSuffix:@"Count"]) {
            unit = @"";
        }
        data[label] = [NSString stringWithFormat:@"%lld%@", value, unit];
        i += 2;
    }
    
    return data;
}

@end
