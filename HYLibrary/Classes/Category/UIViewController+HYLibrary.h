//
//  UIViewController+HYLibrary.h
//  MDPMS
//
//  Created by luculent on 16/6/15.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HYLibrary)

- (void)setupUI ;

@end

@interface UIViewController (HYLibrary)

- (BOOL)isVisible ;

- (void)setupUI ;

@end


@interface UIViewController (Adapt)
/// 设置popover弹框显示位置
/// - Parameters:
///   - sourceView: 弹框显示frame的视图
///   - targetView: 箭头指向的视图
///   - arrowDirection: 箭头方向
- (void)setPopoverSourceView:(UIView *)sourceView targetView:(UIView *)targetView arrowDirection:(UIPopoverArrowDirection)arrowDirection ;

/// 设置popover弹框显示位置
/// - Parameters:
///   - sourceView: 弹框显示frame的视图
///   - sourceRect: 箭头指向的区域
///   - arrowDirection: 箭头方向
- (void)setPopoverSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect arrowDirection:(UIPopoverArrowDirection)arrowDirection ;

@end
