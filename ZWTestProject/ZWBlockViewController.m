//
//  ZWBlockViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/15.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWBlockViewController.h"

@interface ZWBlockViewController ()

@end

@implementation ZWBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger var = 100;
    void (^blk)(void) = ^{
        NSLog(@"%ld",var);
    };
    blk();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
