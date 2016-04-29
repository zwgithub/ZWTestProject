//
//  ZWFmFactorySub.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/29.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWFmFactorySub.h"
#import "ZWFmOperationSub.h"

@implementation ZWFmFactorySub

+(ZWFmOperation *)createOperation {
    return [ZWFmOperationSub new];
}

@end
