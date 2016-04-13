//
//  ZWRuntimeViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/12.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWRuntimeViewController.h"
#import <objc/runtime.h>

//@interface Sark : NSObject
//@end
//@implementation Sark
//@end

@interface ZWRuntimeViewController ()

@end

@implementation ZWRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
//    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
//    BOOL res3 = [(id)[Sark class] isKindOfClass:[Sark class]];
//    BOOL res4 = [(id)[Sark class] isMemberOfClass:[Sark class]];
//    NSLog(@"%d %d %d %d",res1,res2,res3,res4);
    
    
//    //得到所有的类
//    int numClasses;
//    Class *classes = NULL;
//    numClasses = objc_getClassList(NULL,0);
//    NSLog(@"Number of classes: %d", numClasses);
//    
//    if (numClasses >0 ) {
//        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
//        numClasses = objc_getClassList(classes, numClasses);
//        for (int i = 0; i < numClasses; i++) {
//            NSLog(@"Class name: %s",class_getName(classes[i]));
//        }
//        free(classes);
//    }
    
    SEL selector = @selector(didReceiveMemoryWarning);
    NSLog(@"%s",(char *)selector);  //输出 didReceiveMemoryWarning
    NSLog(@"%s",sel_getName(selector)); //输出 didReceiveMemoryWarning
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
