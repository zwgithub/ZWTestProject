//
//  ZWLeakViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/14.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWLeakViewController.h"
#import "ZWHandler.h"

@interface ZWLeakViewController ()

@end

@implementation ZWLeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [ZWHandler makeApiDic:self];
    
   
    id object = [[ZWHandler alloc] init];
    NSLog(@"%@",object);
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
