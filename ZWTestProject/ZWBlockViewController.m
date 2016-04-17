//
//  ZWBlockViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/15.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWBlockViewController.h"
#import "ZWObject.h"

typedef NSInteger (^blk)(NSInteger);
typedef void (^bl)(void);

void (^maxBlk)(void) = ^(void){};

@interface ZWBlockViewController ()

@end

@implementation ZWBlockViewController

- (void)test{
    NSInteger var = 1024;
    void (^blk)(void) = ^{ printf("%ld\n", var); };
    blk();
    NSString *str3 = @"1234";
    NSLog(@"\n堆:%@\n 栈:%@\n 全局:%@\n",blk,^{NSLog(@":%@", str3);},maxBlk);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZWObject *A = [[ZWObject alloc] init];
    [A execBlock];
    NSLog(@"object:%@",A);
    
//    [self test];
    
    
//    NSString *str = [NSString stringWithFormat:@"%@",@"233"];
//    
//    NSInteger var = 100;
//    void (^blk)(void) = ^{
//        NSLog(@"%ld",var);
//    };
//    blk();
//    NSLog(@"block is %@", blk);
//    
//    NSString *str3 = @"1234";
//    NSLog(@"block is %@", ^{NSLog(@":%@", str3);});
    
    
    
//    int count = 1;
//    int (^blk)(int) = ^(int count) {
//        return count + 1;
//    };
//    blk(count);
    
//    NSInteger count = 1;
//    blk testBlk = [self testRutureBlock:count];
//    testBlk(count);
//    
//    
//    NSArray *array = [self gettBlockArray];
//    bl blk0 = (bl)[array objectAtIndex:0];
//    blk0();
}

- (NSArray *)gettBlockArray{
    int num = 916;
    NSArray *array = [[NSArray alloc] initWithObjects:
                      ^{ NSLog(@"this is block 0:%i", num); },
                      ^{ NSLog(@"this is block 1:%i", num); },
                      nil];
    return array;
}

//int test (int var) {
//    return var + 1;
//}
//
//int (*testPtr) = &test;

- (blk)testRutureBlock:(NSInteger)count {
    return ^(NSInteger count){
        NSLog(@"in testRutureBlock");
        return count + 1;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"ZWBlockViewController dealloc");
}

@end
