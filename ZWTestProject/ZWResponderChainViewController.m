//
//  ZWResponderChainViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/10/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWResponderChainViewController.h"
#import "ZWResponderChainView.h"

@interface ZWResponderChainViewController ()

@end

@implementation ZWResponderChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZWResponderChainView *responderView = [[ZWResponderChainView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    responderView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:responderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
