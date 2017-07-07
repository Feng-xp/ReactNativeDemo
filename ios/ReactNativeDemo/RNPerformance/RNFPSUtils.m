//
//  RNFPSUtils.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/7.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "RNFPSUtils.h"

@interface RNFPSUtils()

@end

@implementation RNFPSUtils
{
    NSTimeInterval _prevTime;
    NSUInteger _frameCount;
    NSUInteger _FPS;
    NSUInteger _maxFPS;
    NSUInteger _minFPS;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _frameCount = -1;
        _prevTime = -1;
        _maxFPS = 0;
        _minFPS = 60;
    }
    return self;
}

- (void)onTick:(NSTimeInterval)timestamp
{
    _frameCount++;
    if (_prevTime == -1) {
        _prevTime = timestamp;
    } else if (timestamp - _prevTime >= 1) {
        _FPS = round(_frameCount / (timestamp - _prevTime));
        _minFPS = MIN(_minFPS, _FPS);
        _maxFPS = MAX(_maxFPS, _FPS);
        _prevTime = timestamp;
        _frameCount = 0;
    }
}

@end
