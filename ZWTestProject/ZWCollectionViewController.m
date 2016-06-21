//
//  ZWCollectionViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/6/17.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWCollectionViewController.h"
#import "ZWWaterFlowLayout.h"
#import "ZWPhotoCell.h"
#import "ZWCollectionViewCell.h"
#import "ZWSupplementaryView.h"

static NSString *const cellId = @"cellId";

@interface ZWCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ZWCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ZWWaterFlowLayout *layout = [[ZWWaterFlowLayout alloc] init];
//    layout.columnsCount = 3;
//    
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    collectionView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
////    [collectionView registerNib:[UINib nibWithNibName:@"ZWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:Identi];
//    
//    [self.view addSubview:collectionView];
//    
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *colView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) collectionViewLayout:layout];
    colView.backgroundColor = [UIColor grayColor];
    [colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    [colView registerClass:[ZWSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [colView registerClass:[ZWSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    colView.delegate = self;
    colView.dataSource = self;
    
    [self.view addSubview:colView];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter]){
        reuseIdentifier = @"footer";
    } else {
        reuseIdentifier = @"header";
    }
    
    ZWSupplementaryView *view = [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        view.backgroundColor = [UIColor redColor];
        view.label.text = @"header";
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor greenColor];
        view.label.text = @"footer";
    }
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld,index:%ld",indexPath.section,(long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(96, 100);
}

//定义每个UICollectionView的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}


//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//返回头headerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}

@end
