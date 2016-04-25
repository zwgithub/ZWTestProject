//
//  ZWToolbar.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/24.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWToolbar.h"

@interface ZWToolbar () {
    UILabel *_indexLabel;
}

@end

@implementation ZWToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:17];
        _indexLabel.frame = self.bounds;
        _indexLabel.layer.cornerRadius = 10;
        _indexLabel.layer.masksToBounds = YES;
        _indexLabel.backgroundColor = [UIColor grayColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
    }
    return self;
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    //更新页码
    _indexLabel.text = [NSString stringWithFormat:@"  %d / %d  ", _currentPhotoIndex + 1, _photoTotalCount];
}

@end
