//
//  ZWNonConcurrentOpration.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/27.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWConcurrentOpration.h"

@interface ZWConcurrentOpration ()

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@end

@implementation ZWConcurrentOpration

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)start {
    if (self.isCancelled) {
        _finished = YES;
        return;
    }
    
    _executing = YES;
    //开始执行你的任务
    NSLog(@"ZWConcurrentOpration:%@",[NSThread currentThread]);
    
    //...
    
    _executing = NO;
    _finished = YES;
}

@end
