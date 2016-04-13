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
    
//    Method method1 = class_getInstanceMethod([UIViewController class], @selector(viewDidLoad));
//    Method method2 = class_getInstanceMethod([UIViewController class], @selector(my_viewDidLoad));
//    method_exchangeImplementations(method1, method2);
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
