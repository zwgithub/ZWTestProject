//
//  ZWScrollViewTestViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/22.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWScrollViewTestViewController.h"

@interface ZWScrollViewTestViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZWScrollViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, self.view.width - 40, 300)];
    _scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_scrollView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label1.backgroundColor = [UIColor greenColor];
    label1.text = @"label1";
    [_scrollView addSubview:label1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
