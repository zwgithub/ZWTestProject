//
//  ZWDesignPatternViewController.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/28.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWDesignPatternViewController.h"
#import "Operation.h"
#import "OpreationFactory.h"
#import "ZWFmOperation.h"
#import "ZWFmFactoryAdd.h"
#import "ZWFmFactorySub.h"

@interface ZWDesignPatternViewController ()

@end

@implementation ZWDesignPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
                        @{@"simple_factory" : @"简单工厂模式"},
                        @{@"factory_method" : @"工厂方法模式"},
                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - customFun

/*
    工厂类：根据外界的需求，决定创建并返回哪个具体的抽象子类。在本例子中为 OpreationFactory
    抽象类：定义抽象子类所需的属性和方法，子类通过继承自抽象类获得这些方法。在本例子中为 Operation
    抽象子类：继承自抽象类，是具体操作的实现者。在本例子中为 OperationSub 和 OperationAdd
 */
- (void)simple_factory {
    Operation *op = [OpreationFactory createOperationWithType:ZWOperationAdd];
    op.numberOne = 1;
    op.numberTwo = 2;
    NSLog(@"%f",[op getResult]);
}

/*
    工厂抽象类：定义创建抽象子类的接口，通过接口返回具体的抽象子类。
    工厂子类：继承自工厂抽象类，并重写父类的方法来创建对应的抽象子类。
    抽象类：定义抽象子类所需的属性和方法，子类通过继承自抽象类获得这些方法。
    抽象子类：继承自抽象类，实现具体的操作。
    和上面的简单工厂模式相比，多了个工厂抽象类。
 */
- (void)factory_method {
    ZWFmOperation *operation = [ZWFmFactoryAdd createOperation];
    operation.numberOne = 1;
    operation.numberTwo = 4;
    NSLog(@"%f",[operation getResult]);
    
    ZWFmOperation *op = [ZWFmFactorySub createOperation];
    op.numberOne = 5;
    op.numberTwo = 1;
    NSLog(@"%f",[op getResult]);
}

@end
