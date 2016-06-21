//
//  ZWLabelViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/6/1.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWLabelViewController.h"

@interface ZWLabelViewController ()

@end

@implementation ZWLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 260)];
    label.text = @"Label Text Content, This is a text label things attribute";//默认为空
    label.font = [UIFont systemFontOfSize:27];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    [label sizeToFit];
    
    
    NSString *string = label.text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:NSMakeRange(0,5)];
    
    
    label.attributedText = attrString;
    
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
