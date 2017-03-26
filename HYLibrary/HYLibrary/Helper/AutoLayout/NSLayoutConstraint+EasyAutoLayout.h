//
//  NSLayoutConstraint+EasyAutoLayout.h
//  eStyle
//
//  Created by luculent on 16/8/5.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (EasyAutoLayout)

+(instancetype)equalConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

+(instancetype)lessThanConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

+(instancetype)greaterThanConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

@end
