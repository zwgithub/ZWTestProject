//
//  ZWSupplementaryView.m
//  ZWTestProject
//
//  Created by shanWu on 16/6/21.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWSupplementaryView.h"

@implementation ZWSupplementaryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}

@end
