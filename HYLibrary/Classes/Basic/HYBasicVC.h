//
//  HYBasicVC.h
//  FBSnapshotTestCase
//
//  Created by 杨小山 on 2022/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface HYBasicVC : UIViewController

/// 关闭当前模态视图
- (void)dismissViewController ;
/// 返回导航栏控制器的上一级页面
- (void)popViewController ;
/// 返回导航栏控制器的根页面
- (void)popToRootViewController ;
// 控制当前页面是否可以策划返回，如果禁止测滑返回，子类重写控制
- (BOOL)sideGestureEnable:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer ;

@end

NS_ASSUME_NONNULL_END
