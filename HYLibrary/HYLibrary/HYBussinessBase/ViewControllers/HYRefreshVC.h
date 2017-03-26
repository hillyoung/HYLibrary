//
//  HYRefreshViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseVC.h"



//分区对象：如tableview中的每个分区（亦有人称为“段落”）
@interface HYGroupItem : NSObject

@property (copy, nonatomic) NSString *title;    //分区的标题
@property (copy, nonatomic) id content;     //可以用来持有复杂的数据类型
@property (strong, nonatomic) NSArray *rows ;   //分区中存在的行对象
@property (nonatomic) CGFloat sectionHeaderHeight ;   //段落头的高度
@property (nonatomic) CGFloat sectionFooterHeight ;   //段落头的高度
@property (copy, nonatomic) NSString *viewIdentifier ;  //重用标识符

- (instancetype)initWithTitle:(NSString *)title content:(id)content rows:(NSArray *)rows ;

@end

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
@property (strong, nonatomic) NSArray<HYGroupItem *> *groups;

@property (strong, nonatomic) NSMutableArray *dataList;  //默认只有一组是的数据源


@end

@interface HYRefreshVC : HYBaseVC <HYRefreshActions>

@end
