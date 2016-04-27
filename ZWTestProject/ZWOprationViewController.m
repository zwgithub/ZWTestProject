//
//  ZWOprationViewController.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/27.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWOprationViewController.h"
#import "ZWConcurrentOpration.h"

///////////////////////////////////////////////////////////////

@interface ZWNonConcurrentOpration : NSOperation

@end

@implementation ZWNonConcurrentOpration

- (void)main {
    NSLog(@"ZWNonConcurrentOpration:%@",[NSThread currentThread]);
}

@end

///////////////////////////////////////////////////////////////

@interface ZWOprationViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZWOprationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = @[
                       @{@"testInvocationOpration" : @"NSInvocationOpration"},
                       @{@"testBlockOpration" : @"BlockOpration"},
                       @{@"oprationQueue" : @"oprationQueue"},
                       @{@"nonConcurrent" : @"自定义 opration 非并行"},
                       @{@"concurrent" : @"自定义 opration 并行"},
                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//NSInvocationOperation test
- (void)testInvocationOpration {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
    [op start];
}

- (void)testBlockOpration {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation:%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation1:%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation2:%@",[NSThread currentThread]);
    }];
    [op start];
}

- (void)oprationQueue {
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation2) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation:%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"NSBlockOperation1:%@",[NSThread currentThread]);
    }];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)nonConcurrent {
    ZWNonConcurrentOpration *op = [[ZWNonConcurrentOpration alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

- (void)concurrent {
    ZWConcurrentOpration *op = [[ZWConcurrentOpration alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

#pragma mark - 

- (void) invocationOperation {
    NSLog(@"invocationOperation:%@",[NSThread currentThread]);
}

- (void) invocationOperation1 {
    NSLog(@"invocationOperation:%@",[NSThread currentThread]);
}

- (void) invocationOperation2 {
    NSLog(@"invocationOperation:%@",[NSThread currentThread]);
}

#pragma UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:[[dic allKeys] objectAtIndex:0]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    NSString *str = [[dic allKeys] objectAtIndex:0];
    SEL sel = NSSelectorFromString(str);
    [self performSelector:sel withObject:nil];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
