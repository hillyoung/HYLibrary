//
//  HYBasicAlertView.h
//  SimpleTool
//
//  Created by 2 on 2020/9/29.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 弹框的基类
@interface HYBasicAlertView : UIView
/// 背景图
@property (strong, nonatomic) UIImageView *backgroundView;
/// 弹框内容的容器视图
@property (strong, nonatomic) UIView *contentView;
/// 点击背景是否隐藏弹框
@property (nonatomic) BOOL enableBackdropDismiss;
/// 点击背景图隐藏的回调
@property (nonatomic, copy) void(^backdropDismissBlock)(void);
/// 如果弹出框的样式不符合需求，可在子类重写此方法
/// 在制定的视图上显示弹框
/// @param view 制定的视图：默认keyWindow
/// @param animated 是否启用动画
- (void)showInView:(nullable UIView *)view animated:(BOOL)animated;
/// 如果弹出框的样式不符合需求，可在子类重写此方法
/// 在制定的视图上显示弹框
/// @param view 制定的视图：默认keyWindow
/// @param animated 是否启用动画
/// @param completion 完成的回调
- (void)showInView:(nullable UIView *)view animated:(BOOL)animated completion:(nullable void(^)(void))completion;
/// 隐藏弹框
/// @param animated 是否启用动画
/// @param completion 完成的回调
- (void)dismissAnimated:(BOOL)animated completion:(nullable void(^)(void))completion ;

@end

NS_ASSUME_NONNULL_END
