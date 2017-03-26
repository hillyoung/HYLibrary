//
//  HYLRTitleTextField.h
//  EasyNet
//
//  Created by yanghaha on 15/12/29.
//  Copyright © 2015年 yanghaha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HYLRTextFieldStyleLeft=0,
    HYLRTextFieldStyleRight,
} HYLRTextFieldStyle;

typedef enum : NSUInteger {
    HYLRTextFieldTitleAlignmentLeft,
    HYLRTextFieldTitleAlignmentCenter,
    HYLRTextFieldTitleAlignmentRight,
} HYLRTextFieldTitleAlignment;

@interface HYLRTitleTextField : UITextField
/**
 左侧或者右侧的文字
 */
@property (copy, nonatomic) IBInspectable NSString *title;

@property (nonatomic) IBInspectable CGFloat itemWidth;

@property (strong, nonatomic, readonly) UILabel *label;


/**
 设置标题的对齐方式
 */
#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger titleAlignment;
#else
@property (nonatomic) HYLRTextFieldTitleAlignment titleAlignment;
#endif

@property (nonatomic) IBInspectable BOOL editEnable;

/**
 左侧或者右侧文字颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *titleColor;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger style;
#else
@property (nonatomic) HYLRTextFieldStyle style;
#endif

@end

@interface HYLRImageTextField : UITextField

@property (strong, nonatomic, readonly) UIImageView *imageView;

/**
 左侧或者右侧的图片
 */
@property (copy, nonatomic) IBInspectable UIImage *image;
/**
 左侧或者右侧的图片控件的宽度
 */
@property (nonatomic) IBInspectable CGFloat itemWidth;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger style;
#else
@property (nonatomic) HYLRTextFieldStyle style;
#endif

/**
 *  是否可以编辑
 */
@property (nonatomic) IBInspectable BOOL editEnable;

@property (nonatomic) IBInspectable NSUInteger imageContentType;

@end