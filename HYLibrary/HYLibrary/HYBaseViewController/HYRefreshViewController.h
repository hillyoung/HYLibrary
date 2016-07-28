//
//  HYRefreshViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseViewController.h"

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
@property (strong, nonatomic) NSArray<NSArray *> *groups;

@property (strong, nonatomic) NSMutableArray *dataList;  //默认只有一组是的数据源


@end

@interface HYRefreshViewController : HYBaseViewController <HYRefreshActions>

@end
