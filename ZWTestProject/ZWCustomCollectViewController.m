//
//  ZWCustomCollectViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/6/21.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWCustomCollectViewController.h"
#import "ZWSupplementaryView.h"
#import "ZWWaterFlowLayout.h"

@interface ZWCustomCollectViewController () <UICollectionViewDelegate, UICollectionViewDataSource, ZWWaterFlowLayoutDelegate>

@end

@implementation ZWCustomCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    ZWWaterFlowLayout *layout = [[ZWWaterFlowLayout alloc] init];
    layout.columnsCount = 3;
    layout.delegate = self;
    
    UICollectionView *colView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) collectionViewLayout:layout];
    colView.backgroundColor = [UIColor grayColor];
    [colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    colView.delegate = self;
    colView.dataSource = self;
    
    [self.view addSubview:colView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld,index:%ld",indexPath.section,(long)indexPath.row);
}

#pragma mark ZWWaterFlowLayoutDelegate
- (CGFloat)waterflowLayout:(ZWWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    int from = 50;
    int to = 500;
    CGFloat height = (CGFloat)(from + (arc4random() % (to - from + 1)));
    NSLog(@"height:%f",height);
    return height;
}

@end
