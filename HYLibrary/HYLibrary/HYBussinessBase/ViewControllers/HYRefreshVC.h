//
//  HYRefreshViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseVC.h"
#import "HYSectionDescriber.h"

/**
 定义列表分页是从哪个数字开始，默认是1；根据实际项目需求可以设置
 */
extern NSUInteger startPage ;

//适用于tableview、collectionview的刷新协议
@protocol HYRefreshActions <NSObject>

@optional

/**
 *  注册自定义cell
 */
- (void)registerCellClass:(Class)cellClass ;


/**
 *  下拉刷新更多事件
 */
- (void)headerRefresheAction ;

/**
 *  上拉加载更多事件
 */
- (void)footerRefresheAction ;

/**
 加载数据
 @params shouldCover 是否需要覆盖数据
 */
- (void)loadData:(BOOL)shouldCover ;

/**
 *  header开始刷新
 */
- (void)headerBeginRefresh ;

/**
 *  footer开始刷新
 */
- (void)footerBeginRefresh ;

/**
 *  停止上下拉刷新刷新页面
 */
- (void)endRefresh ;

/**
 *  header是否处于刷新状态
 */
- (BOOL)isHeaderRefreshing ;

/**
 *  footer是否处于刷新状态
 */
- (BOOL)isFooterRefreshing ;

/**
 *  collectionview或tableview的数据源
 */
@property (strong, nonatomic) NSArray<HYSectionDescriber *> *groups;

@property (strong, nonatomic) NSMutableArray *dataList;  //默认只有一组是的数据源

/**
 当前页
 */
@property (nonatomic) NSUInteger page;

@end

@interface HYRefreshVC : HYBaseVC <HYRefreshActions>

@end
