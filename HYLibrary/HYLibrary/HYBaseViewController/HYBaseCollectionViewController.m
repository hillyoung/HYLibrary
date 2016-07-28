//
//  HYBaseCollectionViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseCollectionViewController.h"

@interface HYBaseCollectionViewController ()

@end

@implementation HYBaseCollectionViewController

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
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

#pragma mark - Private

- (void)addCollectionViewHeaderReresh {
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresheAction)];
}

- (void)addCollectionViewFooterReresh {
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresheAction)];
}


#pragma mark - Message

- (void)setupCollectionView {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo (self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)registerCellClass:(Class)cellClass {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerHeaderFooterClass:(Class)headerFooterClass elementKind:(NSString *)elementKind {
    [self.collectionView registerClass:headerFooterClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(headerFooterClass)];
}

- (void)headerBeginRefresh {
    [self.collectionView.header beginRefreshing];
}

- (void)footerBeginRefresh {
    [self.collectionView.footer beginRefreshing];
}

/**
 *  结束collectionview上拉或下拉刷新
 */
- (void)endRefresh {
    if (self.collectionView.header.isRefreshing) {
        [self.collectionView.header endRefreshing];
    }
    
    if (self.collectionView.footer.isRefreshing) {
        [self.collectionView.footer endRefreshing];
    }
}

@end
