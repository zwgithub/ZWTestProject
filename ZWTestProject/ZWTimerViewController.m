//
//  ZWTimerViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/10/14.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWTimerViewController.h"

@interface ZWTimerViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZWTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction {
    NSLog(@"timerAction");
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
