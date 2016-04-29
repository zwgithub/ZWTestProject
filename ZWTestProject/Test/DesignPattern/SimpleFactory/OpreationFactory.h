//
//  OpreationFactory.h
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/28.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Operation;

extern NSString *const ZWOperationAdd;
extern NSString *const ZWOperationSub;


@interface OpreationFactory : NSObject

+ (Operation *)createOperationWithType:(NSString *)type;

@end
