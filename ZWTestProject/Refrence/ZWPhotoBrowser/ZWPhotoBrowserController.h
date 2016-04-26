//
//  ZWPhotoBrowserController.h
//  ZWTestProject
//
//  Created by shanWu on 16/4/23.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWPhotoBrowserController : UIViewController

+ (void)showImageUrls:(NSArray *)urlStrArray showIndex:(NSInteger)index placeholder:(UIImage *)placeholder;

@end
