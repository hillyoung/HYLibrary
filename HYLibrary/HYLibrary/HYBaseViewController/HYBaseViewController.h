//
//  HYBaseViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/3.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYNoDataView.h"

@interface HYBaseViewController : UIViewController {
    @protected
    //导航栏按钮（目的是防止某些情况下，既需要隐藏又需要显示）
    UIBarButtonItem *_rightItem;
    NSArray *_rightItems;
    UIBarButtonItem *_leftItem;
    NSArray *_leftItems;
}

/**
 *  初始化数据源
 */
- (void)initDatasource ;

/**
 *  更新数据源
 */
- (void)updateDatasource ;

/**
 *  通过制定数据更新数据源
 */
- (void)updateDatasource:(id)data ;

/**
 *  通过title，设置导航栏左侧按钮
 */
- (void)setupLeftItemWithTitle:(NSString *)title ;

/**
 *  通过image，设置导航栏左侧按钮
 */
- (void)setupLeftItemWithImage:(UIImage *)image ;

/**
 *  设置导航栏左侧多个按钮
 */
- (void)setupLeftItems:(NSArray *)items ;

/**
 *  通过title，设置导航栏右侧按钮
 */
- (void)setupRightItemWithTitle:(NSString *)title ;

/**
 *  通过image，设置导航栏右侧按钮
 */
- (void)setupRightItemWithImage:(UIImage *)image ;

/**
 *  设置导航栏右侧多个按钮
 */
- (void)setupRightItems:(NSArray *)items ;

/**
 *  设置导航栏左侧按钮事件
 */
- (void)leftItemAction ;

/**
 *  设置导航栏右侧按钮事件
 */
- (void)rightItemAction ;

/**
 *  退出视图控制器
 */
- (void)popOrDismiss ;

@end
