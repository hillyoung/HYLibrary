//
//  UIView+EffectAnimation.h
//  FlipView
//
//  Created by yanghaha on 15/9/18.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIViewEffectAnimationShakeDirectionX,
    UIViewEffectAnimationShakeDirectionY,
    UIViewEffectAnimationShakeDirectionUpperLeftCorner,
    UIViewEffectAnimationShakeDirectionUpperRightCorner
} UIViewEffectAnimationShakeDirection;

typedef void(^EffectAnimationBlock)(void);

@interface UIView (EffectAnimation)

/**
 *添加翻转动画
 *@params transition 翻转方向
 **/
- (void)animationTransition:(UIViewAnimationTransition)transition;

/**
 *添加倒影
 *@params opacity 透明度
 *@params percent 缩放百分比
 *@params distance 距离
 **/
- (void)addReflectionOpacity:(CGFloat)opacity percent:(CGFloat)percent distance:(CGFloat)distance;

/**
 *  阴影
 *
 *  @param color   阴影颜色
 *  @param size    阴影大小
 *  @param opacity 不透明度（默认是透明的：0）（0--1.0）
 */
- (void)shadowShadowColor:(UIColor*)color andSize:(CGSize)size andOpacity:(CGFloat)opacity;

/**
 *  弧度抖动
 *  @param angel       抖动的弧度
 *  @param time        动画时间
 *  @param repeatCount 重复次数
 *  @param save        是否保存动画
 */
- (void)shakeAngel:(CGFloat)angel andDuration:(NSTimeInterval)time andRepeatCount:(NSInteger)repeatCount andSave:(BOOL)save;

/**
 *  方向抖动
 *  @param distance    抖动的距离
 *  @param time        抖动的时间
 *  @param repeatCount 抖动的次数
 *  @param direction   抖动的方向
 */
- (void)shakeDistance:(CGFloat)distance andDuration:(NSTimeInterval)time andRepeateCount:(NSInteger)repeatCount andDirection:(UIViewEffectAnimationShakeDirection)direction;

/**
 *  方向抖动
 *  @param distance    抖动的距离
 *  @param time        抖动的时间
 *  @param repeatCount 抖动的次数
 *  @param direction   抖动的方向
 *  @param block       动画执行完成回调方法
 */

- (void)shakeDistance:(CGFloat)distance andDuration:(NSTimeInterval)time andRepeateCount:(NSInteger)repeatCount andDirection:(UIViewEffectAnimationShakeDirection)direction block:(EffectAnimationBlock)block;

/**
 *  圆角
 *
 *  @param radius 圆角半径大小
 */
- (void)addCornerAngel:(CGFloat)radius;

/**
 *  边框
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)addBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor*)borderColor;

/**
 *  边框
 *
 *  @param radius 圆角半径大小
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)addBorderAndCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

@interface UIView (Circle)

#if TARGET_INTERFACE_BUILDER
#else
#endif

/**
 是否显示为圆圈
 */
@property (nonatomic) IBInspectable BOOL circle;
/**
 圆圈半径
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/**
 边框的宽度
 */
@property (nonatomic) IBInspectable CGFloat borderWidth;
/**
 边框的颜色
 */
@property (nonatomic) IBInspectable UIColor *borderColor;

@end