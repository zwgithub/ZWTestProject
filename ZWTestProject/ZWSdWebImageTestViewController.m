//
//  ZWSdWebImageTestViewController.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/27.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWSdWebImageTestViewController.h"
#import "SDWebImageManager.h"

@interface ZWSdWebImageTestViewController ()

@end

@implementation ZWSdWebImageTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSString *str = @"https://raw.githubusercontent.com/zwgithub/blog_pic/master/animal_city4.jpg";
    NSURL *url = [NSURL URLWithString:str];
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"receivedSize:%ld",receivedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        NSLog(@"completed");
    }];
}

@end
