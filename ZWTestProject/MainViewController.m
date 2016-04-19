//
//  MainViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "MainViewController.h"
#import "ZWAssociatedViewController.h"
#import "ZWRuntimeViewController.h"
#import "ZWForwardInvocationViewController.h"
#import "ZWLeakViewController.h"
#import "ZWBlockViewController.h"
#import "ZWWebViewJavascriptBridgeController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"各种测试";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = @[
                   @{@"ZWAssociatedViewController" : @"关联对象测试"},
                   @{@"ZWRuntimeViewController" : @"运行时常用函数"},
                   @{@"ZWForwardInvocationViewController" : @"消息转发测试"},
                   @{@"ZWLeakViewController" : @"泄漏测试"},
                   @{@"ZWBlockViewController" : @"Block 原理探究"},
                   @{@"ZWWebViewJavascriptBridgeController" : @"OC 与 JS 交互"},
                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:[[dic allKeys] objectAtIndex:0]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    ZWBaseViewController *clazz = [[NSClassFromString([[dic allKeys] objectAtIndex:0]) alloc] init];
    clazz.navTitleStr = [dic objectForKey:[[dic allKeys] objectAtIndex:0]];
    [self.navigationController pushViewController:(UIViewController *)clazz animated:YES];
}

@end
