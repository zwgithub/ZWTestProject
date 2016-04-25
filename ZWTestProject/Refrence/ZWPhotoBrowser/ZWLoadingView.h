//
//  ZWLoadingView.h
//  ZWTestProject
//
//  Created by shanWu on 16/4/25.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinProgress 0.0001

@interface ZWLoadingView : UIView

@property (nonatomic) float progress;
@property (nonatomic, strong) UILabel *failureLabel;

- (void)showLoading;
- (void)showFailure:(BOOL)show;

@end
