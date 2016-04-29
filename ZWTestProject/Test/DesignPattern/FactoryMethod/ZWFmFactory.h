//
//  ZWFmFactory.h
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/28.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZWFmOperation;

@interface ZWFmFactory : NSObject

+(ZWFmOperation *)createOperation;

@end
