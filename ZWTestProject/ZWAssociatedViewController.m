//
//  ZWAssociatedViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//
//  这里给 UIAlertView 设置关联对象来测试，iOS8以后应该用 UIAlertController,所以这里有一大堆警告。
//
//

#import "ZWAssociatedViewController.h"
#import <objc/runtime.h>

static void *ZWAssociatedKey = "ZWAssociatedKey";

@interface ZWAssociatedViewController () <UIAlertViewDelegate>

@end

@implementation ZWAssociatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
//                                                                   message:@"This is an alert."
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
//                                                          handler:^(UIAlertAction * action) {
//                                                              NSLog(@"test");
//                                                          }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *testAction = [UIAlertAction actionWithTitle:@"test" style:UIAlertActionStyleDestructive handler:nil];
//    UIAlertAction *testAction1 = [UIAlertAction actionWithTitle:@"test1" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:defaultAction];
//    [alert addAction:cancelAction];
//    [alert addAction:testAction];
//    [alert addAction:testAction1];
//    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    void (^block)(NSInteger) = ^(NSInteger buttonIndex){
        if (0 == buttonIndex) {
            NSLog(@"取消");
        } else {
            NSLog(@"确定");
        }
    };
    
    objc_setAssociatedObject(alert, ZWAssociatedKey, block, OBJC_ASSOCIATION_COPY);
    
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, ZWAssociatedKey);
    block(buttonIndex);
}

@end
