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
#import "ZWLoadingView.h"

@interface ZWPhotoView () <UIScrollViewDelegate> {
    BOOL _doubleTap;
    UIImageView *_imageView;
    CGRect _imageFrame;
}

@end

@implementation ZWPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        //图片
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        //进度条
        _photoLoadingView = [[ZWLoadingView alloc] init];
        
        //属性
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //监听点击
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
- (void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    _doubleTap = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide:tap];
    });
}

//双击放大处理
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    _doubleTap = YES;
    
    CGPoint touchPoint = [tap locationInView:_imageView];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

#pragma mark - 隐藏图片
- (void)hide:(UITapGestureRecognizer *)tap
{
    if (_doubleTap) {
        return;
    }
    
    //移除进度条
    [_photoLoadingView removeFromSuperview];
    self.contentOffset = CGPointZero;
    
    if (1 != self.zoomScale) {
        CGPoint touchPoint = [tap locationInView:self];
        if (self.zoomScale == self.maximumZoomScale) {
            [self setZoomScale:self.minimumZoomScale animated:YES];
        } else {
            [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.26 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
            [self.photoViewDelegate photoViewSingleTap:self];
        }
        
        CGFloat duration = 0.15;
        [UIView animateWithDuration:duration + 0.1 animations:^{
            _imageView.frame = CGRectMake(self.frame.size.width/2, (self.frame.origin.y + self.frame.size.height)/2, 0, 0);
        } completion:^(BOOL finished) {
            if ([self.photoViewDelegate respondsToSelector:@selector(photoViewDidEndZoom:)]) {
                [self.photoViewDelegate photoViewDidEndZoom:self];
            }
        }];
    });
}

- (void)setPhoto:(ZWPhoto *)photo
{
    _photo = photo;
    [self showImage];
}

#pragma mark 显示图片
- (void)showImage
{
    if (_photo.firstShow) { //首次显示
        
        _imageView.image = _photo.placeholder; //占位图片
        
        //不是gif，就马上开始下载
        if (![_photo.url.absoluteString hasSuffix:@"gif"]) {
            __weak ZWPhotoView *photoView = self;
            __weak ZWPhoto *photo = _photo;
            __weak ZWLoadingView *loading = _photoLoadingView;
            [_photoLoadingView showLoading];
            [self addSubview:_photoLoadingView];
            
            [_imageView sd_setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                if (receivedSize > kMinProgress) {
                    loading.progress = (float)receivedSize/expectedSize;
                }
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
    //调整frame参数
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
        //直接显示进度条
        [_photoLoadingView showLoading];
        [self addSubview:_photoLoadingView];
        
        __weak ZWPhotoView *photoView = self;
        __weak ZWLoadingView *loading = _photoLoadingView;
        
        [_imageView sd_setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (receivedSize > kMinProgress) {
                loading.progress = (float)receivedSize/expectedSize;
            }
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
        [_photoLoadingView removeFromSuperview];
        
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewImageFinishLoad:)]) {
            [self.photoViewDelegate photoViewImageFinishLoad:self];
        }
    } else {
        [self addSubview:_photoLoadingView];
        BOOL isShowFailure=YES;
        if([[_photo.url absoluteString] isEqualToString:@""]){
            isShowFailure=NO;
        }
        [_photoLoadingView showFailure:isShowFailure];
    }
    
    //调整缩放比例
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
    
    CGFloat minScale = 1;
    CGFloat maxScale = 3;
    self.zoomScale = minScale;
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;

    _imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    self.contentSize = CGSizeMake(0, _imageFrame.size.height);
    
    _imageFrame.origin.x = floorf( (boundsWidth - _imageFrame.size.width ) / 2.0);
    _imageFrame.origin.y = floorf( (boundsHeight - _imageFrame.size.height ) / 2.0);
    
    if (_photo.firstShow) { //第一次显示的图片
        _photo.firstShow = NO;  //已经显示过了
        
        _imageView.frame = CGRectMake(self.frame.size.width/2, (self.frame.origin.y + self.frame.size.height)/2, 0, 0);
        [UIView animateWithDuration:0.3  animations:^{
            _imageView.frame = _imageFrame;
        } completion:^(BOOL finished) {
            [self photoStartLoad];
        }];
    } else {
        _imageView.frame = _imageFrame;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

//让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.zoomScale == scrollView.maximumZoomScale) {
        _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5,
                                        scrollView.contentSize.height * 0.5);
    } else if (scrollView.zoomScale == scrollView.minimumZoomScale){
        _imageView.frame = _imageFrame;
    } else if (scrollView.zoomScale > scrollView.minimumZoomScale) {
        CGFloat xcenter = scrollView.center.x;
        CGFloat ycenter = scrollView.center.y;
        xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
        ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
        [_imageView setCenter:CGPointMake(xcenter, ycenter)];
    }
}

@end
