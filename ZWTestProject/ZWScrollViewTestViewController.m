//
//  ZWScrollViewTestViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/22.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWScrollViewTestViewController.h"

@interface ZWScrollViewTestViewController () <UIScrollViewDelegate> {
    UIImageView *_imageView;
    CGRect _imageFrame;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZWScrollViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, self.view.width - 40, self.view.height - 64 - 40)];
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.delegate = self;
    _scrollView.zoomScale = 1;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 3;
    [self.view addSubview:_scrollView];
    
    UIImage *image = [UIImage imageNamed:@"animal_city1.jpg"];
    CGSize imageSize = image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGSize boundsSize = _scrollView.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    _imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    _scrollView.contentSize = CGSizeMake(0, _imageFrame.size.height);
    _imageFrame.origin.x = floorf( (boundsWidth - _imageFrame.size.width ) / 2.0);
    _imageFrame.origin.y = floorf( (boundsHeight - _imageFrame.size.height ) / 2.0);
    
    
    _imageView = [[UIImageView alloc] initWithFrame:_imageFrame];
    _imageView.image = image;
    [_scrollView addSubview:_imageView];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer:doubleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    CGPoint touchPoint = [tap locationInView:_imageView];
    NSLog(@"touchPoint:%@",NSStringFromCGPoint(touchPoint));
    if (_scrollView.zoomScale == _scrollView.maximumZoomScale) {
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
    } else {
        [_scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
//    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ?
//    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//    
//    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
//    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
//    
//    NSLog(@"bouns width:%f,contentSize width:%f",scrollView.bounds.size.width,scrollView.contentSize.width);
//    NSLog(@"bouns height:%f,contentSize height:%f",scrollView.bounds.size.height,scrollView.contentSize.height);
//    NSLog(@"x:%f,y:%f",offsetX,offsetY);
//    
//    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
//                                    scrollView.contentSize.height * 0.5 + offsetY);
    
    NSLog(@"%f",scrollView.zoomScale);
    
    if (scrollView.zoomScale == scrollView.minimumZoomScale) {
        _imageView.frame = _imageFrame;
    } else {
        _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5,
                                        scrollView.contentSize.height * 0.5);
    }
}


@end
