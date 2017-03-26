//
//  UINavigationItem+NoBackTitle.h
//  navigationTitle
//
//  Created by luculent on 16/4/19.
//  Copyright © 2016年 luculent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (CustomBackTitleImage)

/**
 *  设置交换backBarButtonItem方法和customBackButtonItem方法
 *  并设置将要显示的返回按钮的title
 *  @param title 需要设置的title,如果设置title为nil，那么将会默认跟随系统设置
 */
+ (void)exchangeBetweenBackItemWithCustomBackItemUsedTitle:(NSString *)title;

/**
 *  设置交换backBarButtonItem方法和customBackButtonItem方法
 *  并设置将要显示的返回按钮的title、image
 *  @param title 需要设置的title,如果设置title为nil，那么将会默认跟随系统设置
 *  @param image 需要设置的image
 */
+ (void)exchangeBetweenBackItemWithCustomBackItemUsedTitle:(NSString *)title image:(UIImage *)image;

@end
