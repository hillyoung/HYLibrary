//
//  HYFloatingView.h
//  SimpleTool
//
//  Created by 杨小山 on 2022/4/17.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义的浮窗控件
@interface HYFloatingView : UIView

/// 在指定视图中显示
/// @param superView 父视图
- (void)showInView:(UIView *)superView ;

@end

NS_ASSUME_NONNULL_END
