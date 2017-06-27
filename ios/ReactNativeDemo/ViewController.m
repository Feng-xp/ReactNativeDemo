//
//  ViewController.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/6/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "ViewController.h"

#import <React/RCTRootView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 120)/2, 120, 120, 60)];
    [button setTitle:@"走进React" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:button];
}

- (void)onButtonTapped:(UIButton *)button
{
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    
//    jsCodeLocation = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"index.ios.jsbundle" ofType:nil]];
    
    NSDictionary *props = @{
                            @"scores" : @[
                                    @{
                                        @"name" : @"Alex",
                                        @"value": @"42"
                                        },
                                    @{
                                        @"name" : @"Joel",
                                        @"value": @"10"
                                        }
                                    ]
                            };
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                                        moduleName: @"RNHighScores"
                                                 initialProperties:props
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
