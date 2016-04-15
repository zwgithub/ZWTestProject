//
//  ZWHandler.h
//  ZWTestProject
//
//  Created by shanWu on 16/4/14.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^blk_t)(void);

@interface ZWHandler : NSObject

+ (void)makeApiDic:(id)dic;

@end
