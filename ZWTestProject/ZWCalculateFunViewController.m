//
//  ZWCalculateFunViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/30.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWCalculateFunViewController.h"

@interface ZWCalculateFunViewController ()

@end

@implementation ZWCalculateFunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //常数阶
    int a = 1;  //执行一次
    a = a + 1;  //执行一次
    printf("%d",a); //执行一次
    
    //线性阶
    int n = 100;    //执行一次
    for (int i = 0; i < n; i++) {
        printf("%d",i); //执行 n 次
    }
    
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; i++) {
            printf("%d",i);
        }
    }
    
    int i = 1;
    while (i < n) {
        i = i * 2;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
