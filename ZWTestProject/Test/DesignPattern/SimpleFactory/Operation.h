//
//  Operation.h
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/28.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//
//  定义抽象类
//

#import <Foundation/Foundation.h>

@interface Operation : NSObject

@property (nonatomic, assign) CGFloat numberOne;
@property (nonatomic, assign) CGFloat numberTwo;

- (CGFloat)getResult;

@end
