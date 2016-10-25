//
//  ZWWillMoveToSuperViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/10/25.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWWillMoveToSuperViewController.h"
#import "ZWMoveToSuperView.h"
#import "ZWSubMoveToSuperView.h"

@interface ZWWillMoveToSuperViewController () {
//    ZWMoveToSuperView *_moveToSuperView;
    ZWSubMoveToSuperView *_moveToSuperView;
}

@end

@implementation ZWWillMoveToSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _moveToSuperView = [[ZWSubMoveToSuperView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _moveToSuperView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_moveToSuperView];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

- (void)buttonAction {
    NSLog(@"buttonAction");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
