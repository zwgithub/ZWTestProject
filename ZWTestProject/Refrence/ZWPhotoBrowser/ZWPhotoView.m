//
//  ZWPhotoView.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/23.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWPhotoView.h"
#import "ZWPhoto.h"
#import "UIImageView+WebCache.h"

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

- (void)setPhoto:(ZWPhoto *)photo {
    _photo = photo;
    
    [self showImage];
}

#pragma mark 显示图片
- (void)showImage
{
    if (_photo.firstShow) { // 首次显示
        
        _imageView.image = _photo.placeholder; // 占位图片
        
        // 不是gif，就马上开始下载
        if (![_photo.url.absoluteString hasSuffix:@"gif"]) {
            __weak ZWPhotoView *photoView = self;
            __weak ZWPhoto *photo = _photo;
//            __weak MJPhotoLoadingView *loading = _photoLoadingView;
//            [_photoLoadingView showLoading];
//            [self addSubview:_photoLoadingView];
            
            [_imageView sd_setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                if (receivedSize > kMinProgress) {
//                    loading.progress = (float)receivedSize/expectedSize;
//                }
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                photo.image = image;
                [photoView adjustFrame];
                [photoView photoDidFinishLoadWithImage:image];
            }];
            
        } else {
            [self photoStartLoad];
        }
        
    } else {
        [self photoStartLoad];
    }
    // 调整frame参数
    [self adjustFrame];
}

#pragma mark 开始加载图片
- (void)photoStartLoad
{
    if (_photo.image) {
        self.scrollEnabled = YES;
        _imageView.image = _photo.image;
    } else {
        self.scrollEnabled = NO;
        // 直接显示进度条
//        [_photoLoadingView showLoading];
//        [self addSubview:_photoLoadingView];
        
        __weak ZWPhotoView *photoView = self;
//        __weak MJPhotoLoadingView *loading = _photoLoadingView;
        
        [_imageView sd_setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            if (receivedSize > kMinProgress) {
//                loading.progress = (float)receivedSize/expectedSize;
//            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [photoView photoDidFinishLoadWithImage:image];
        }];
    }
}

#pragma mark 加载完毕
- (void)photoDidFinishLoadWithImage:(UIImage *)image
{
    if (image) {
        self.scrollEnabled = YES;
        _photo.image = image;
//        [_photoLoadingView removeFromSuperview];
        
//        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewImageFinishLoad:)]) {
//            [self.photoViewDelegate photoViewImageFinishLoad:self];
//        }
    } else {
//        [self addSubview:_photoLoadingView];
        BOOL isShowFailure=YES;
        if([[_photo.url absoluteString] isEqualToString:@""]){
            isShowFailure=NO;
        }
//        [_photoLoadingView showFailure:isShowFailure];
    }
    
    // 设置缩放比例
    [self adjustFrame];
}

#pragma mark 调整frame
- (void)adjustFrame
{
    if (_imageView.image == nil) {
        return;
    }
    
    // 基本尺寸参数
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 设置伸缩比例
    CGFloat widthRatio = boundsWidth/imageWidth;
    CGFloat heightRatio = boundsHeight/imageHeight;
    CGFloat minScale = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    if (minScale >= 1) {
        minScale = 0.8f;
    }
    minScale = 1;
    
    CGFloat maxScale = 2.0;
    
    //	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
    //		maxScale = maxScale / [[UIScreen mainScreen] scale];
    //	}
    if ([self isScrollEnabled]) {
        self.maximumZoomScale = maxScale;
        self.minimumZoomScale = minScale;
        self.zoomScale = minScale;
        self.bouncesZoom = YES;
    } else {
        self.maximumZoomScale = minScale;
        self.minimumZoomScale = minScale;
        self.zoomScale = minScale;
        self.bouncesZoom = NO;
    }
    
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // 宽大
    //    if ( imageWidth <= imageHeight &&  imageHeight <  boundsHeight ) {
    //        imageFrame.origin.x = floorf( (boundsWidth - imageFrame.size.width ) / 2.0) * minScale;
    //        imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0) * minScale;
    //    } else {
    //        imageFrame.origin.x = floorf( (boundsWidth - imageFrame.size.width ) / 2.0);
    //        imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0);
    //    }
    
    imageFrame.origin.x = floorf( (boundsWidth - imageFrame.size.width ) / 2.0);
    imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0);
    
    
    
    //    // y值
    //    if (imageFrame.size.height < boundsHeight) {
    //
    //        imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0) * minScale;
    //
    ////        imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0) * minScale;
    //
    //	} else {
    //        imageFrame.origin.y = 0;
    //	}
    
    if (_photo.firstShow) { // 第一次显示的图片
        _photo.firstShow = NO; // 已经显示过了
        
        //        _imageView.frame = [_photo.srcImageView convertRect:_photo.srcImageView.bounds toView:nil];
        _imageView.frame = CGRectMake(self.width/2, self.height/2, 0, 0);
        [UIView animateWithDuration:0.3  animations:^{
            
            _imageView.frame = imageFrame;
        } completion:^(BOOL finished) {
            // 设置底部的小图片
//            _photo.srcImageView.image = _photo.placeholder;
            [self photoStartLoad];
        }];
    } else {
        _imageView.frame = imageFrame;
    }
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
