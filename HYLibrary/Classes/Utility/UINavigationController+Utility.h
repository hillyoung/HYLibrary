//
//  UINavigationController+Utility.h
//  SimpleTool
//
//  Created by hillyoung on 2020/12/22.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Utility)
/// 以系统样式、block的方式构造UIBarButtonItem，注意循环引用
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void(^)(UIBarButtonItem *barItem))actionBlock;
/// 以指定title、block的方式构造UIBarButtonItem，注意循环引用
- (instancetype)initWithTitle:(NSString *)title actionBlock:(void (^)(UIBarButtonItem *barItem))actionBlock ;
/// 以指定image、block的方式构造UIBarButtonItem，注意循环引用
- (instancetype)initWithImage:(UIImage *)image actionBlock:(void (^)(UIBarButtonItem *barItem))actionBlock ;

@end

@interface UINavigationController (Utility)

@end

NS_ASSUME_NONNULL_END
