//
//  HYAlertView.h
//  HYAlertViewDemo
//
//  Created by yanghaha on 15/10/12.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HYAlertViewStyle) {
    HYAlertViewStyleDefault = 0,
    HYAlertViewStyleSecureTextInput,
    HYAlertViewStylePlainTextInput,
    HYAlertViewStyleLoginAndPasswordInput
};

@interface HYAlertView : UIView

@property (nonatomic,strong) UILabel *msgLabel;

/**
 *消息字体大小(alertViewStyle为Default),否则为输入框字体大小
 **/
@property (nonatomic,strong) UIFont *messageFont;

@property (nonatomic) BOOL   seriesAlert;

@property (nonatomic) HYAlertViewStyle alertViewStyle;

@property (strong, nonatomic) UIColor *destructiveColor;

/**
 *  @两个按钮纯文本显示（block回调方式）
 */
-(id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;

/**
 *  显示弹出框
 */
-(void)showWithCompletion:(void (^)(HYAlertView *alertView ,NSInteger selectIndex))completeBlock;

/**
 *  在指定视图中显示弹出框
 */
-(void)showInView:(UIView *)baseView completion:(void (^)(HYAlertView *alertView ,NSInteger selectIndex))completeBlock;

/**
 *获取指定的textField
 **/
- (UITextField *)textFieldAtIndex:(NSInteger)textFieldIndex;

@end
