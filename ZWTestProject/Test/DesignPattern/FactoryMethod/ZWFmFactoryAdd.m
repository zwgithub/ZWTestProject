//
//  ZWFmFactoryAdd.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/28.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWFmFactoryAdd.h"
#import "ZWFmOperationAdd.h"

@implementation ZWFmFactoryAdd

+(ZWFmOperation *)createOperation {
    return [ZWFmOperationAdd new];
}

@end
