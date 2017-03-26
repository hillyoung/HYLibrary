//
//  NSLayoutConstraint+EasyAutoLayout.m
//  eStyle
//
//  Created by luculent on 16/8/5.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "NSLayoutConstraint+EasyAutoLayout.h"

@implementation NSLayoutConstraint (EasyAutoLayout)

+ (instancetype)equalConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attr2 multiplier:multiplier constant:constant];
}

+ (instancetype)lessThanConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:NSLayoutRelationLessThanOrEqual toItem:view2 attribute:attr2 multiplier:multiplier constant:constant];
}

+ (instancetype)greaterThanConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view2 attribute:attr2 multiplier:multiplier constant:constant];
}

@end
