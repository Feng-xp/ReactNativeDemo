//
//  RNPerfMonitor.h
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/7.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCTBridge;

@interface RNPerfMonitor : NSObject

- (void)startMonitorWithBrige:(RCTBridge *)brigde;
- (NSDictionary *)performanceInfo;
- (NSDictionary *)performanceInfoWithoutFPSWithBridge:(RCTBridge *)bridge;
- (void)stopMonitor;

@end
