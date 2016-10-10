//
//  ZWCalculateFunViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/30.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWCalculateFunViewController.h"

@interface ZWCalculateFunViewController ()

@end

@implementation ZWCalculateFunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //常数阶
//    int a = 1;  //执行一次
//    a = a + 1;  //执行一次
//    printf("%d",a); //执行一次
//    
//    //线性阶
//    int n = 100;    //执行一次
//    for (int i = 0; i < n; i++) {
//        printf("%d",i); //执行 n 次
//    }
//    
//    for (int i = 0; i < n; i++) {
//        for (int j = 0; j < n; i++) {
//            printf("%d",i);
//        }
//    }
//    
//    int i = 1;
//    while (i < n) {
//        i = i * 2;
//    }
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"2",@"3",@"5",@"4",@"1",nil];
//    [self bubbleSort:array];
//    [self quickSortWithArray:array left:0 right:array.count - 1];
    [self insertSort:array];
    [self printArray:array];
}

//冒泡排序
- (NSMutableArray *)bubbleSort:(NSMutableArray *)array {
    NSInteger n = array.count;
    for (NSInteger i = 0; i < n; i++) {
        //这里注意下，一定是 n - 1 -i,要不会数组越界
        for (NSInteger j = 0; j < n - 1 - i; j++) {
            NSInteger a = [[array objectAtIndex:j] intValue];
            NSInteger b = [[array objectAtIndex:j+1] intValue];
            if (a > b) {
                [array replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%ld",b]];
                [array replaceObjectAtIndex:j+1 withObject:[NSString stringWithFormat:@"%ld",a]];
            }
        }
    }
    return array;
}

//快速排序
-(NSMutableArray *)quickSortWithArray:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right{
    if (right > left) {
        NSInteger x = [[array objectAtIndex:left] integerValue];
        NSInteger i = left;
        NSInteger j = right;
        while (i < j) {
            //从右向左找第一个小于x的数
            while (i < j && [[array objectAtIndex:j] integerValue] >= x) {
                j--;
            }
            if (i < j) {
                [array replaceObjectAtIndex:i++ withObject:[array objectAtIndex:j]];
            }
            
            //从左向右找第一个大于等于x的数
            while (i < j && [[array objectAtIndex:i] integerValue] < x) {
                i++;
            }
            if (i < j) {
                [array replaceObjectAtIndex:j-- withObject:[array objectAtIndex:i]];
            }
        }
        
        [array replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",x]];
        [self quickSortWithArray:array left:left right:i-1];
        [self quickSortWithArray:array left:i+1 right:right];
    }
    return array;
}

//直接插入排序
- (NSMutableArray *)insertSort:(NSMutableArray *)array {
    //假定第一个是排好序的，所以 i 从 1 开始
    for (NSInteger i = 1; i < array.count; i++) {
        NSInteger j = i;
        NSInteger target = [[array objectAtIndex:i] integerValue];
        
        while (j > 0 && target < [[array objectAtIndex:j - 1] integerValue]) {
            [array replaceObjectAtIndex:j withObject:[array objectAtIndex:j - 1]];
            j--;
        }
        [array replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%ld",target]];
    }
    return array;
}

-(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2 {
    NSNumber *tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}



- (void)printArray:(NSMutableArray *)array {
    NSInteger count = array.count;
    for (NSInteger i = 0; i < count; i++) {
        NSLog(@"排好的顺序为：%@\n",[array objectAtIndex:i]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
