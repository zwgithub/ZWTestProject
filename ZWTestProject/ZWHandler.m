//
//  ZWHandler.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/14.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWHandler.h"

@interface ZWHandler () {
    blk_t _blk;
}

@property(nonatomic ,strong) NSMutableDictionary *delegateMap;

@end

@implementation ZWHandler

- (id)init{
    self = [super init];
    if (self) {
        _blk = ^{
            NSLog(@"%@",self);
        };
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"ZWHandler dealloc!");
}

+(ZWHandler *)sharedInstance{
    static ZWHandler *instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[ZWHandler alloc] init];
    });
    
    return instance;
}

- (NSMutableDictionary *)delegateMap{
    if (!_delegateMap) {
        _delegateMap = [NSMutableDictionary dictionary];
    }
    return _delegateMap;
}


+ (void)makeApiDic:(id)dic
{
    [[ZWHandler sharedInstance].delegateMap setObject:dic forKey:@"23"];
    //不加下面这句的话会引起泄漏，这里只是测试，没有任何实际意义
    [[ZWHandler sharedInstance].delegateMap removeObjectForKey:@"23"];
}


@end
