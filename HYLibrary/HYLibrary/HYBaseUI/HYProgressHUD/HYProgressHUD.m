//
//  HYProgressHUD.m
//  HYLibrary
//
//  Created by luculent on 16/7/29.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYProgressHUD.h"

float tostaDelay = 1;

@implementation HYProgressHUD

+ (void)showTosta:(NSString *)msg {
    [self showTosta:msg hideAfterDelay:tostaDelay];
}

+(void)showTosta:(NSString *)msg hideAfterDelay:(NSTimeInterval)times
{

    //    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    //    HUD.detailsLabelFont = HUD.labelFont;
    //    HUD.detailsLabelText = msg;
    //    HUD.mode = MBProgressHUDModeText;
    //
    //    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    //    HUD.yOffset = 150.0f;
    //    //    HUD.xOffset = 100.0f;
    //
    //
    //    [HUD hide:YES afterDelay:times];

    [self showTosta:msg view:[[[UIApplication sharedApplication] delegate] window] hideAfterDelay:times];
}

+ (void)showTosta:(NSString *)msg view:(UIView *)view hideAfterDelay:(NSTimeInterval)times {
    HYProgressHUD *HUD = [HYProgressHUD showHUDAddedTo:view animated:YES];
    HUD.detailsLabel.font = HUD.label.font;
    HUD.detailsLabel.text = msg;
    HUD.mode = MBProgressHUDModeText;

    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;

    [HUD hideAnimated:YES afterDelay:times];
}

+(id)showProgress:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];

    return hud;
}

+ (id)showTitle:(NSString *)title view:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = title;
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    return hud;
}

@end
