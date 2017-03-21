//
//  TestStickyViewController.m
//  HYLibrary
//
//  Created by luculent on 16/9/8.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "TestStickyViewController.h"
#import "HYCollectionViewStickyLayout.h"
#import "LKCollectionViewFlowLayout.h"

@interface TestStickyViewController ()

@end

@implementation TestStickyViewController
@synthesize flowLayout = _flowLayout;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self registerCellClass:[UICollectionViewCell class]];
    [self registerHeaderFooterClass:[UICollectionReusableView class] elementKind:UICollectionElementKindSectionHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[HYCollectionViewStickyLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(100, 100);
        _flowLayout.headerReferenceSize = CGSizeMake(100, 44);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }

    return _flowLayout;
}

- (void)headerRefresheAction {
    [self endRefresh];
}

- (void)footerRefresheAction {
    [self endRefresh];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 60;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }
    
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    
    if (!view) {
        view = [[UICollectionReusableView alloc] init];
    }

    view.backgroundColor = [UIColor greenColor];
    
    return view;
}

@end
