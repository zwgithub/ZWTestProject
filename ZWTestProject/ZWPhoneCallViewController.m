//
//  ZWPhoneCallViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/5/17.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWPhoneCallViewController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface ZWPhoneCallViewController ()

@end

@implementation ZWPhoneCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CTCallCenter *center = [[CTCallCenter alloc] init];
    center.callEventHandler = ^(CTCall *call) {
        NSLog(@"电话状态 :%@",[call description]);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
