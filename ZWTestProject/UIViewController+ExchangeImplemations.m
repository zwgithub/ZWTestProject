//
//  UIViewController+ExchangeImplemations.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/13.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "UIViewController+ExchangeImplemations.h"

@implementation UIViewController (ExchangeImplemations)

- (void)my_viewDidLoad {
    NSString *str = NSStringFromClass([self class]);
    NSLog(@"***:%@",str);
    [self my_viewDidLoad];
}

@end
