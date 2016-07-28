//
//  HYBaseCollectionViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYRefreshViewController.h"

@interface HYBaseCollectionViewController : HYRefreshViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
   
//    NSArray *_groups;   //组数
    NSUInteger _page;       //分页,默认设置为0
}

/**
 *  <#Description#>
 */
@property (strong, nonatomic) UICollectionView *collectionView ;

/**
 *  uicollectionview的样式
 */
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout ;

/**
 *  主要是设置collectionview的尺寸位置，基类中默认设为上下左右边距为0
 */
- (void)setupCollectionView;

/**
 *  注册自定义header或footer
 */
- (void)registerHeaderFooterClass:(Class)headerFooterClass elementKind:(NSString *)elementKind ;


@end
