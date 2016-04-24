//
//  ZWPhotoBrowserController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/23.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWPhotoBrowserController.h"
#import "ZWPhoto.h"
#import "ZWPhotoView.h"
#import "SDWebImageManager+ZWAdditions.h"

#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface ZWPhotoBrowserController () <UIScrollViewDelegate>
{
    UIScrollView *_photoScrollView; //展示图片的scrollview
    
    NSMutableSet *_visiblePhotoViews;   //所有的图片view
    NSMutableSet *_reusablePhotoViews;  //重利用
    BOOL _statusBarHiddenInited;    //一开始的状态栏
}

@property (nonatomic, assign) NSUInteger currentPhotoIndex; //当前显示的第几张
@property (nonatomic, strong) NSMutableArray * photos;  //所有的图片对象

@end

@implementation ZWPhotoBrowserController

#pragma mark - 生命周期
- (void)loadView
{
//    _statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
//    // 隐藏状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//    self.view = [[UIView alloc] init];
//    self.view.frame = [UIScreen mainScreen].bounds;
//    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIScrollView
    [self createScrollView];
    
    // 2.创建工具条
    [self createToolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 创建UIScrollView
- (void)createScrollView
{
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    _photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
    _photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _photoScrollView.pagingEnabled = YES;
    _photoScrollView.delegate = self;
    _photoScrollView.showsHorizontalScrollIndicator = NO;
    _photoScrollView.showsVerticalScrollIndicator = NO;
    _photoScrollView.backgroundColor = [UIColor clearColor];
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
    [self.view addSubview:_photoScrollView];
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
}

#pragma mark 创建工具栏
- (void)createToolbar
{
//    CGFloat barHeight = 44;
//    
//    //    CGFloat barHeight = 0;
//    CGFloat barY = self.view.frame.size.height - barHeight;
//    _toolbar = [[MJPhotoToolbar alloc] init];
//    _toolbar.Delegate = self;
//    _toolbar.frame = CGRectMake((self.view.frame.size.width - 60) / 2, barY, 60, barHeight);
//    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    _toolbar.photos = _photos;
//    [self.view addSubview:_toolbar];
//    
//    [self updateTollbarState];
}

#pragma mark - 提供给外部调用的接口
+ (void)showImageUrls:(NSArray *)urlStrArray showIndex:(NSInteger)index {
    if (0 == urlStrArray.count) {
        return;
    }
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:urlStrArray.count];
    for (int i = 0; i < urlStrArray.count; i++) {
        NSString *urlStr = urlStrArray[i];
        ZWPhoto *photo = [[ZWPhoto alloc] init];
        photo.url = [NSURL URLWithString:urlStr];
        [photos addObject:photo];
    }
    
    // 2.显示相册
    ZWPhotoBrowserController *browser = [[ZWPhotoBrowserController alloc] init];
    [browser setPhotos:photos showIndex:index]; //设置所有图片和要显示的第几张
    [browser show];
    return;
}

- (void)setPhotos:(NSMutableArray *)photos showIndex:(NSInteger)index {
    if (!_photos) {
        _photos = [NSMutableArray new];
    }
    
    _currentPhotoIndex = index;
    _photos = photos;
    if (photos.count > 1) {
        _visiblePhotoViews = [NSMutableSet set];
        _reusablePhotoViews = [NSMutableSet set];
    }
    
    for (int i = 0; i<_photos.count; i++) {
        ZWPhoto *photo = _photos[i];
        photo.index = i;
        photo.firstShow = i == _currentPhotoIndex;
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    
    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark 显示照片
- (void)showPhotos
{
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = _photoScrollView.bounds;
    NSLog(@"visibleBounds:%@",NSStringFromCGRect(visibleBounds));
    NSInteger firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
    NSInteger lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    
    if (firstIndex >= _photos.count) {
        firstIndex = _photos.count - 1;
    }
    
    if (lastIndex < 0) {
        lastIndex = 0;
    }
    
    if (lastIndex >= _photos.count) {
        lastIndex = _photos.count - 1;
    }
    
    
    //回收不再显示的ImageView
    NSInteger photoViewIndex;
    for (ZWPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
        if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
            [_reusablePhotoViews addObject:photoView];
            [photoView removeFromSuperview];
        }
    }
    
    [_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
    
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        if (![self isShowingPhotoViewAtIndex:index]) {
            [self showPhotoViewAtIndex:index];
        }
    }
}

#pragma mark 加载index附近的图片
- (void)loadImageNearIndex:(NSInteger)index
{
    if (index > 0) {
        ZWPhoto *photo = _photos[index - 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
    
    if (index < _photos.count - 1) {
        ZWPhoto *photo = _photos[index + 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(NSInteger)index
{
    ZWPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[ZWPhotoView alloc] init];
//        photoView.photoViewDelegate = self;
    }
    
    // 调整当期页的frame
    CGRect bounds = _photoScrollView.bounds;
    
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    ZWPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
    for (ZWPhotoView *photoView in _visiblePhotoViews) {
        if (kPhotoViewIndex(photoView) == index) {
            return YES;
        }
    }
    return  NO;
}

#pragma mark 循环利用某个view
- (ZWPhotoView *)dequeueReusablePhotoView
{
    ZWPhotoView *photoView = [_reusablePhotoViews anyObject];
    if (photoView) {
        [_reusablePhotoViews removeObject:photoView];
    }
    return photoView;
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
//    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
//    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_photos.count == 1) {
        return;
    }
    [self showPhotos];
    [self updateTollbarState];
}

@end
