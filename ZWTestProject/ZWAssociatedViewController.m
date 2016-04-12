//
//  ZWAssociatedViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWAssociatedViewController.h"
#import <objc/runtime.h>

@interface ZWAssociatedViewController ()

@end

@implementation ZWAssociatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitleStr;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              NSLog(@"test");
                                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *testAction = [UIAlertAction actionWithTitle:@"test" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *testAction1 = [UIAlertAction actionWithTitle:@"test1" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [alert addAction:testAction];
    [alert addAction:testAction1];
    [self presentViewController:alert animated:YES completion:nil];
    
    
//    objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
