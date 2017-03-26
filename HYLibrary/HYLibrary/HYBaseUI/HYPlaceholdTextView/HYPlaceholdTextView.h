//
//  HYPlaceholdTextView.h
//  PlaceholdTextView
//
//  Created by yanghaha on 15/7/27.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPlaceholdTextView : UITextView

/**
 *  提示文字颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *titleColor;

/**
 @brief 设置默认的提示文字
 */
@property (nonatomic, copy) IBInspectable NSString *placehold;

/**
 设置字数限制字长
 */
@property (nonatomic) IBInspectable NSUInteger wordCount;

/**
 placehold的字体大小
 */
@property (strong, nonatomic) UIFont *placeholdFont;

/**
 *@return 获取默认文字label
 **/
- (UILabel *)placeholdLabel;

/**
 *@return 获取字数限制label
 **/
- (UILabel *)wordCountLabel;

/**
 *设置originX
 **/
@property (nonatomic, assign) IBInspectable CGFloat labelOriginX;

/**
 *设置originY
 **/
@property (nonatomic, assign) IBInspectable CGFloat labelOriginY;

/**
 输入字数超过限制时，触发block的回调
 */
@property (nonatomic, copy) NSString *(^didExceedBlock)(NSString *text);

@end
