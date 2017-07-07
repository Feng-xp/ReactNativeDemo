//
//  RNFPSUtils.h
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/7.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNFPSUtils : NSObject

@property (nonatomic, assign, readonly) NSUInteger FPS;
@property (nonatomic, assign, readonly) NSUInteger maxFPS;
@property (nonatomic, assign, readonly) NSUInteger minFPS;

- (void)onTick:(NSTimeInterval)timestamp;

@end
