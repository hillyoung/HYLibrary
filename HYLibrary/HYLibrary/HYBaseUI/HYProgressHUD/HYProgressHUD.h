//
//  HYProgressHUD.h
//  HYLibrary
//
//  Created by luculent on 16/7/29.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

extern float tostaDelay;

@interface HYProgressHUD : MBProgressHUD

+ (void)showTosta:(NSString *)msg;

+ (void)showTosta:(NSString *)msg hideAfterDelay:(NSTimeInterval)times;

+ (void)showTosta:(NSString *)msg view:(UIView *)view hideAfterDelay:(NSTimeInterval)times;

+(id)showProgress:(UIView *)view animated:(BOOL)animated;

/**
 *@params title:显示的标题 view:父视图 animated:是否启用动画
 **/
+ (id)showTitle:(NSString *)title view:(UIView *)view animated:(BOOL)animated;

@end
