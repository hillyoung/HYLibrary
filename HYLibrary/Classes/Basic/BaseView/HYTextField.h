//
//  SDTextField.h
//  SimpleTool
//
//  Created by hillyoung on 2020/12/17.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 可设置内边距的TextField
@interface HYTextField : UITextField
/// 控件内边距
@property (nonatomic) UIEdgeInsets contentInset;

@end

NS_ASSUME_NONNULL_END
