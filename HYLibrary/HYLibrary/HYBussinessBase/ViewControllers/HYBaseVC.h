//
//  HYBaseViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/3.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYNoDataView.h"

/**
 *  创建UIViewController的数据源，可以适用于动态调整页面
 */
@interface HYVCConfigModel : NSObject

/**
 *  如果UIViewController是从storyboard加载UIViewController，
 *  那么此属性为storyboard的名字
 */
@property (copy, nonatomic) NSString *storyName ;

/**
 在storyboard中的标识符:storyboardID
 */
@property (copy, nonatomic) NSString *storyBoardID;

/**
 *  如果UIViewController是从storyboard加载UIViewController，
 *  那么此属性为storyboard中UIViewController的标识符，
 *  如果UIViewController是用代码来创建的，那么此属性为UIViewController的类名
 */
@property (copy, nonatomic) NSString *viewControllerClass ;


- (instancetype)initWithstoryName:(NSString *)storyName
              viewControllerClass:(NSString *)viewControllerClass ;

/**
 *  根据storyName、storyboardID来获取新建一个UIViewController
 *  如果设置了storyboard，先判断是否设置了storyboardID，如果设置了则直接通过storyboardID来创建，否则直接返回story的instantiateInitialViewController
 *  如果未设置storyboardID，则根据是否设置了viewcontrollerClass，如果设置了，直接通过 alloc、init方法创建一个视图控制器，否则返回"nil"
 */
- (UIViewController *)viewController ;

@end


@interface HYBaseVC : UIViewController {
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
