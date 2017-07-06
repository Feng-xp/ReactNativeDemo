//
//  RNProfileView.h
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/6.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCTBridge;

@interface RNProfileView : NSObject

- (void)setBridge:(RCTBridge *)bridge;
- (void)show;

@end
