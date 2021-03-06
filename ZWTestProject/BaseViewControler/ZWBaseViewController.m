//
//  ZWBaseViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWBaseViewController.h"
#import <objc/runtime.h>

@interface ZWBaseViewController ()

@end

@implementation ZWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitleStr;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<8.0) ||
        [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [self.navigationController setNavigationBarHidden:NO];
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    Method method1 = class_getInstanceMethod([UIViewController class], @selector(viewDidLoad));
//    Method method2 = class_getInstanceMethod([UIViewController class], @selector(my_viewDidLoad));
//    method_exchangeImplementations(method1, method2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
