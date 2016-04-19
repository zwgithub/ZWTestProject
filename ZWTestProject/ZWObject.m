//
//  ZWObject.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/17.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWObject.h"

typedef void(^blk)(void);

@interface ZWObject () {
    blk _blk;
}

@end

@implementation ZWObject

- (instancetype)init {
    self = [super init];

    __weak typeof(self) weakSelf = self;
    _blk = ^{
        NSLog(@"%@",weakSelf);
    };
    
//    [self test:@"1" :_blk :@""];
    
    return self;
}

- (void)execBlock {
    _blk();
}

- (void)test:(NSString *)str :(blk)haha :(NSString *)string{
    _blk();
}

- (void)dealloc {
    NSLog(@"ZWObject dealloc");
}

- (NSString *)description {
    return @"123";
}

@end
