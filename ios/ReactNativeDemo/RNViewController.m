//
//  RNViewController.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/7/6.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "RNViewController.h"
#import "RNProfileView.h"
#import <React/RCTRootView.h>

@interface RNViewController ()

@property (nonatomic) RNProfileView *profile;

@end

@implementation RNViewController

- (instancetype)initWithBundleURL:(NSURL *)bundleURL
                       moduleName:(NSString *)moduleName
                initialProperties:(NSDictionary *)initialProperties
                    launchOptions:(NSDictionary *)launchOptions
{
    self = [self init];
    if (self) {
        RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:bundleURL
                                                            moduleName:moduleName
                                                     initialProperties:initialProperties
                                                         launchOptions:launchOptions];
        self.view = rootView;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    self.profile = [[RNProfileView alloc] init];
//    [_profile setBridge:((RCTRootView*)self.view).bridge];
//    [_profile show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
