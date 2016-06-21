//
//  ZWPickerViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/5/11.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWPickerViewController.h"

@interface ZWPickerViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation ZWPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, self.view.width, 200)];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 20;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return @"123";
    }
    return @"234";
}


@end
