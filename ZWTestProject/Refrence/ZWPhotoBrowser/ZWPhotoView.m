//
//  ZWPhotoView.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/23.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWPhotoView.h"

@interface ZWPhotoView () <UIScrollViewDelegate> {
    BOOL _doubleTap;
    UIImageView *_imageView;
//    MJPhotoLoadingView *_photoLoadingView;
}

@end

@implementation ZWPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        // 图片
        _imageView = [[UIImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        // 进度条
//        _photoLoadingView = [[MJPhotoLoadingView alloc] init];
        
        // 属性
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

#pragma mark - 手势处理
//单击隐藏处理
- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = NO;
    [self performSelector:@selector(hide) withObject:nil afterDelay:0.2];
}

//双击放大处理
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = YES;
    
    CGPoint touchPoint = [tap locationInView:self];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

//隐藏图片
- (void)hide
{
//    if (_doubleTap) return;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    
//    // 移除进度条
//    [_photoLoadingView removeFromSuperview];
//    self.contentOffset = CGPointZero;
//    
//    // 清空底部的小图
//    [_photo.srcImageView setHidden:YES];
//    
//    CGFloat duration = 0.15;
//    if (_photo.srcImageView.clipsToBounds) {
//        [self performSelector:@selector(reset) withObject:nil afterDelay:duration];
//    }
//    
//    // 通知代理
//    if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
//        [self.photoViewDelegate photoViewSingleTap:self];
//    }
//    
//    [UIView animateWithDuration:duration + 0.1 animations:^{
//        //        _imageView.frame = [_photo.srcImageView convertRect:_photo.srcImageView.bounds toView:nil];
//        
//        _imageView.frame = CGRectMake(self.width/2, self.height/2, 0, 0);
//        
//        //看情况是否打开差状态栏的20
//        //        if (![[UIApplication sharedApplication] isStatusBarHidden]) {
//        //            _imageView.top -= 20;
//        //        }
//        
//        // gif图片仅显示第0张
//        if (_imageView.image.images) {
//            _imageView.image = _imageView.image.images[0];
//        }
//        
//    } completion:^(BOOL finished) {
//        // 设置底部的小图片
//        [_photo.srcImageView setHidden:NO];
//        
//        // 通知代理
//        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewDidEndZoom:)]) {
//            [self.photoViewDelegate photoViewDidEndZoom:self];
//        }
//    }];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"bounds:%@",NSStringFromCGRect(scrollView.bounds));
    NSLog(@"contentSize:%@",NSStringFromCGSize(scrollView.contentSize));
    NSLog(@"imageview:%@",NSStringFromCGSize(_imageView.frame.size));
    NSLog(@"center:%@",NSStringFromCGPoint(_imageView.center));
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
    NSLog(@"修改后center:%@",NSStringFromCGPoint(_imageView.center));
}

@end
