//
//  HYBaseTableViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/22.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseTableViewController.h"

#define KVO_HYBaseTableView_dataList @"dataList"

@interface HYBaseTableViewController ()

@end

@implementation HYBaseTableViewController

- (instancetype)init {
    if (self = [super init]) {
        _page = 0;
        _tableViewFooterUpdate = YES;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _page = 0;
    _tableViewFooterUpdate = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatasource];
    
    //此处可能注册观察者可能会存在问题
    [self observeDataList];
    
    [self setupUI];
    [self.view addSubview:self.tableView];
    [self setupTableView];
    
    if ([self respondsToSelector:@selector(headerRefresheAction)]) {
        [self addHeaderReresh];
    }
    
    if ([self respondsToSelector:@selector(footerRefresheAction)]) {
        [self addFooterReresh];
    }
    
    [(MJRefreshBackStateFooter *)self.tableView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    //防止“因没有注册观察者”导致异常
    if (self.isViewLoaded) {
        [self removeObserver:self forKeyPath:KVO_HYBaseTableView_dataList];
    }
}

#pragma mark - Private

/**
 *  添加观察者
 */
- (void)observeDataList {
    [self addObserver:self forKeyPath:KVO_HYBaseTableView_dataList options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial context:nil];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:KVO_HYBaseTableView_dataList]) {
        if (self.tableViewFooterUpdate) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateTableViewFooterNoData:!self.dataList.count];
            });
        }
    }
}

#pragma mark - Setter && Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _tableView;
}

#pragma mark - Private

/**
 *  添加下拉刷新
 */
- (void)addHeaderReresh {
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresheAction)];
}

/**
 *  添加上拉加载更多
 */
- (void)addFooterReresh {
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresheAction)];
}

#pragma mark - Message

- (void)setupTableView {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo (self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)registerCellClass:(Class)cellClass {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerHeaderFooterClass:(Class)headerFooterClass {
    [self.tableView registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerFooterClass)];
}

- (void)headerBeginRefresh {
    [self.tableView.mj_header beginRefreshing];
}

- (void)footerBeginRefresh {
    [self.tableView.mj_footer beginRefreshing];
}

- (BOOL)isHeaderRefreshing {
    return self.tableView.mj_header.isRefreshing;
}

- (BOOL)isFooterRefreshing {
    return self.tableView.mj_footer.isRefreshing;
}

/**
 *  结束tableView上拉或下拉刷新
 */
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)updateTableViewFooterNoData:(BOOL)noData {
    //    ShowNoDataView *view = [[ShowNoDataView alloc] initWithFrame:[UIScreen mainScreen].bounds withShowImgName:@"NoPici" withShowLabText:@"暂无数据"];
    //    self.tableView.tableFooterView = noData? view:[[UIView alloc] initWithFrame:CGRectZero];
    [self hy_updateTableViewFooterNoData:noData];
}

- (void)hy_updateTableViewFooterNoData:(BOOL)noData {
    
    HYNoDataView *nodataView = [[HYNoDataView alloc] initWithFrame:self.tableView.frame title:@"没有数据"];
    self.tableView.tableFooterView = noData? nodataView:[[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDatasource && UITabelViewDelege

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
