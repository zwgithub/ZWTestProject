//
//  ZWPhotoView.h
//  ZWTestProject
//
//  Created by shanWu on 16/4/23.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

@class ZWPhoto;
@class ZWPhotoView;

#import <UIKit/UIKit.h>

@protocol ZWPhotoViewDelegate <NSObject>

- (void)photoViewImageFinishLoad:(ZWPhotoView *)photoView;
- (void)photoViewSingleTap:(ZWPhotoView *)photoView;
- (void)photoViewDidEndZoom:(ZWPhotoView *)photoView;

@end

@interface ZWPhotoView : UIScrollView

@property (nonatomic, strong) ZWPhoto *photo;
@property (nonatomic, weak) id<ZWPhotoViewDelegate> photoViewDelegate;

@end
