//
//  ZWMoveToSuperView.m
//  ZWTestProject
//
//  Created by shanWu on 16/10/25.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWMoveToSuperView.h"

@implementation ZWMoveToSuperView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"newSuperview:%@",newSuperview);
}

@end
