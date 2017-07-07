//
//  RNEventEmitter.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/7.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "RNEventEmitter.h"

@interface RNEventEmitter()
{
    void* _eventEmitterQueueTag;
}

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation RNEventEmitter

RCT_EXPORT_MODULE()

- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventEmitterQueueTag = &_eventEmitterQueueTag;
        _queue = dispatch_queue_create("rn.event.emitter.queue", NULL);
        dispatch_queue_set_specific(_queue, _eventEmitterQueueTag, _eventEmitterQueueTag, NULL);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendEventFromAppToJavaScript:) name:@"EventNativeToJs" object:nil];
    }
    return self;
}

- (void)sendEventFromAppToJavaScript:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *eventName = userInfo[@"event"];
    if (eventName.length == 0)
    {
        return;
    }
    id eventBody = userInfo[@"body"];
    
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block = ^{
        [weakSelf sendEventWithName:eventName body:eventBody];
    };
    
    if (dispatch_get_specific(_eventEmitterQueueTag))
    {
        block();
    }
    else
    {
        dispatch_async(_queue, block);
    }
    
}

- (NSArray<NSString *> *)supportedEvents
{
    NSMutableArray<NSString *> *events = [[NSMutableArray alloc] init];
    [events addObject:@"performanceEvent"];
    return [events copy];
}

- (dispatch_queue_t)methodQueue
{
    return _queue;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
