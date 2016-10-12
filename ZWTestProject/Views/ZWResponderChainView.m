//
//  ZWResponderChainView.m
//  ZWTestProject
//
//  Created by shanWu on 16/10/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWResponderChainView.h"

@interface ZWResponderChainView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ZWResponderChainView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(80, 80, self.width - 160, self.height - 160)];
        _backView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_backView];
        
        _button = [[UIButton alloc] initWithFrame:CGRectMake(-50, -50, 100, 100)];
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_button];
    }
    return self;
}

- (void)buttonAction {
    NSLog(@"button Action");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
//    NSLog(@"point:%@",NSStringFromCGPoint(point));
        CGPoint tempPonit = [_button convertPoint:point fromView:self];
        if (CGRectContainsPoint(_button.bounds, tempPonit)) {
            view = _button;
        }
    return view;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    if (CGRectContainsPoint(_button.bounds, point)) {
//        return YES;
//    }
//    return NO;
//}

@end
