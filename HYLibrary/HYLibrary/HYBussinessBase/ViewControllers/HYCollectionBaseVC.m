//
//  HYBaseCollectionViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYCollectionBaseVC.h"

@interface HYCollectionBaseVC ()

@end

@implementation HYCollectionBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    
    [self initDatasource];
    [self setupUI];
    [self.view addSubview:self.collectionView];
    [self setupCollectionView];
    
    if ([self respondsToSelector:@selector(headerRefresheAction)]) {
        [self addCollectionViewHeaderReresh];
    }
    
    if ([self respondsToSelector:@selector(footerRefresheAction)]) {
        [self addCollectionViewFooterReresh];
    }
    
}

#pragma mark - Setter && Getter

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

#pragma mark - Private

- (void)addCollectionViewHeaderReresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresheAction)];
}

- (void)addCollectionViewFooterReresh {
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresheAction)];
}


#pragma mark - Message

- (void)setupCollectionView {

    [self.view addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeTop toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

- (void)registerCellClass:(Class)cellClass {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerHeaderFooterClass:(Class)headerFooterClass elementKind:(NSString *)elementKind {
    [self.collectionView registerClass:headerFooterClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(headerFooterClass)];
}

- (void)headerBeginRefresh {
    [self.collectionView.mj_header beginRefreshing];
}

- (void)footerBeginRefresh {
    [self.collectionView.mj_footer beginRefreshing];
}

/**
 *  结束collectionview上拉或下拉刷新
 */
- (void)endRefresh {
    if (self.collectionView.mj_header.isRefreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    
    if (self.collectionView.mj_footer.isRefreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
