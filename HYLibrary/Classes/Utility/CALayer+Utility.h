//
//  CALayer+Utility.h
//  SimpleTool
//
//  Created by hillyoung on 2022/1/7.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Utility)

/// 获取图层上指定点的颜色：数组元素分别是 red green blue alpha
/// @param point 点
- (UIColor *)colorInPoint:(CGPoint)point ;
/// 获取指定区域的图片
/// @param rect 指定区域
- (UIImage *)imageAtRect:(CGRect)rect ;
/// 获取当前图层对应的图片
/// @param completion 获取图片后的回调
- (void)getImageWithCompletion:(void(^)(UIImage *image))completion ;

@end

NS_ASSUME_NONNULL_END
