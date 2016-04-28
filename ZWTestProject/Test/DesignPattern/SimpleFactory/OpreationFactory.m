//
//  OpreationFactory.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/28.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "OpreationFactory.h"
#import "Operation.h"

//static NSString *kOperationAdd = @"OperationAdd";
//static NSString *kOperationSub = @"OperationSub";

NSString *const ZWOperationAdd = @"OperationAdd";
NSString *const ZWOperationSub = @"OperationSub";

@implementation OpreationFactory

+ (Operation *)createOperationWithType:(NSString *)type {
    return [NSClassFromString(type) new];
}

@end
