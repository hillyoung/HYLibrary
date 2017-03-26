//
//  HYBaseTableViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/22.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYRefreshVC.h"

//#define HYBaseTableView_NAME tableView

@interface HYTableBaseVC : HYRefreshVC <UITableViewDelegate, UITableViewDataSource> {

    NSUInteger _page ;       //分页,默认设置为0
    NSUInteger _total ;
}


/**
 *  tableViewFooter是否更新，默认为yes
 */
@property (nonatomic) BOOL tableViewFooterUpdate ;

//@property (strong, nonatomic) UITableView *HYBaseTableView_NAME;
@property (strong, nonatomic) UITableView *tableView;

/**
 *  主要是设置tableView的尺寸位置，基类中默认设为上下左右边距为0
 */
- (void)setupTableView ;

/**
 *  设置标示图底部视图，是否为默认的无数据
 */
- (void)updateTableViewFooterNoData:(BOOL)noData ;

- (void)hy_updateTableViewFooterNoData:(BOOL)noData ;

/**
 *  注册自定义header或footer
 */
- (void)registerHeaderFooterClass:(Class)headerFooterClass ;

@end
