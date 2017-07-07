//
//  RNPerfMonitorManager.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/7.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "RNPerfMonitorManager.h"

@implementation RNPerfMonitorManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(performanceInfo:(NSString *)pageTag)
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"BridgeStartup"] = @"44070ms";
    dict[@"BundleSize"] = @"1684218b";
    dict[@"JSCExecutorSetup"] = @"0ms";
    
    NSMutableDictionary *eventDict = [NSMutableDictionary dictionary];
    eventDict[@"event"] = @"performanceEvent";
    eventDict[@"body"] = dict;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EventNativeToJs" object:nil userInfo:eventDict];
}

@end
