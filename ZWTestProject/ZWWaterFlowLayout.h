//
//  ZWWaterFlowLayout.h
//  ZWTestProject
//
//  Created by shanWu on 16/6/20.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWWaterFlowLayout;

@protocol ZWWaterFlowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(ZWWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface ZWWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<ZWWaterFlowLayoutDelegate> delegate;

@end
