//
//  ZWPhotoBrowserViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/21.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWPhotoBrowserViewController.h"
#import "ZWPhotoBrowserController.h"

@interface ZWPhotoBrowserViewController ()

@end

@implementation ZWPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createRightItem {
    UIButton *rightItemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [rightItemButton addTarget:self action:@selector(rightItemButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rightItemButton setTitle:@"测试" forState:UIControlStateNormal];
    [rightItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
}

- (void)rightItemButtonAction {
    NSArray *url = @[@"http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif", @"https://raw.githubusercontent.com/zwgithub/blog_pic/master/animal_city1.jpg",@"https://raw.githubusercontent.com/zwgithub/blog_pic/master/animal_city2.jpg",@"https://raw.githubusercontent.com/zwgithub/blog_pic/master/animal_city3.jpg"];
    [ZWPhotoBrowserController showImageUrls:url showIndex:0];
}

@end
