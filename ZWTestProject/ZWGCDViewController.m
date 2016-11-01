//
//  ZWGCDViewController.m
//  ZWTestProject
//
//  Created by 曹振伟 on 16/4/27.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWGCDViewController.h"

@interface ZWGCDViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZWGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = @[
                       @{@"serial_dispatch" : @"串行队列"},
                       @{@"concurrent_dispatch" : @"并行队列"},
                       @{@"dispatch_group" : @"dispatch_group"},
                       @{@"dispatch_after" : @"dispatch_after"},
                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (void)serial_dispatch {

}

- (void)concurrent_dispatch {
    
}

- (void)dispatch_group {
    
}

- (void)dispatch_after {
    
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
    //直接用 performSelector: 会产生 PerformSelector may cause a leak because its selector is unknown 警告。如果直接用 [self performSelector:@selector(serial_dispatch) withObject:nil] 来调用则不会产生警告，因为在编译期间返回值信息一经确认。如果直接用 [self performSelector:sel withObject:nil] 的话，这些信息是不确认的，所以产生了警告。
    
    //SEL sel = NSSelectorFromString(str);
    //[self performSelector:sel withObject:nil];
    
    [self performSelector:@selector(serial_dispatch) withObject:nil];
    SEL selector = NSSelectorFromString(str);
    IMP imp = [self methodForSelector:selector];
    void (*fun)() = (void*)imp;
    fun();
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
