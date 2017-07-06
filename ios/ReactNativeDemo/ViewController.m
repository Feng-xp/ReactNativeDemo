//
//  ViewController.m
//  ReactNativeDemo
//
//  Created by qzp on 2017/6/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "ViewController.h"
#import "RNViewController.h"

@interface JSModuleObject : NSObject

@property (nonatomic) NSString  *moduleKey;
@property (nonatomic) NSString  *moduleUrl;
@property (nonatomic) NSString  *moduleName;

+ (JSModuleObject *)objectWithKey:(NSString *)key url:(NSString *)url name:(NSString *)name;

@end

@implementation JSModuleObject

+ (JSModuleObject *)objectWithKey:(NSString *)key url:(NSString *)url name:(NSString *)name
{
    JSModuleObject *object = [[JSModuleObject alloc] init];
    object.moduleKey = key;
    object.moduleUrl = url;
    object.moduleName = name;
    return object;
}

@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView   *tableView;
@property (nonatomic) NSArray       *datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    _datasource = @[[JSModuleObject objectWithKey:@"UI Interface" url:@"js/FlatList/index.ios.bundle" name:@"NewsList"],
                    [JSModuleObject objectWithKey:@"Animation" url:@"js/index.ios.bundle" name:@"RNHighScores"],
                    [JSModuleObject objectWithKey:@"Gesture" url:@"js/index.ios.bundle" name:@"RNHighScores"],
                    [JSModuleObject objectWithKey:@"Native" url:@"js/index.ios.bundle" name:@"RNHighScores"],
                    [JSModuleObject objectWithKey:@"UI Interface" url:@"js/index.ios.bundle" name:@"RNHighScores"],
                    [JSModuleObject objectWithKey:@"UI Interface" url:@"js/index.ios.bundle" name:@"RNHighScores"],
                    [JSModuleObject objectWithKey:@"UI Interface" url:@"js/index.ios.bundle" name:@"RNHighScores"]];
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = ((JSModuleObject *)_datasource[indexPath.row]).moduleKey;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JSModuleObject *object = _datasource[indexPath.row];
    
    NSString *url = [NSString stringWithFormat:@"http://localhost:8081/%@?platform=ios",object.moduleUrl];
    NSURL *jsCodeLocation = [NSURL URLWithString:url];
    
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
    
    [self.navigationController pushViewController:[[RNViewController alloc] initWithBundleURL:jsCodeLocation moduleName:object.moduleName initialProperties:props launchOptions:nil] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
