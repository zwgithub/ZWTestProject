//
//  SDWebImageManager+ZWAdditions.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/23.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "SDWebImageManager+ZWAdditions.h"

@implementation SDWebImageManager (ZWAdditions)

+ (void)downloadWithURL:(NSURL *)url
{
    //下载照片
    [[self sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        ;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        ;
    }];
}

@end
