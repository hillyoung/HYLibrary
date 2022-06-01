//
//  SDTextField.m
//  SimpleTool
//
//  Created by hillyoung on 2020/12/17.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import "HYTextField.h"

CGRect CGRectFromInset(CGRect rect, UIEdgeInsets inset) {
    CGFloat originX = CGRectGetMinX(rect) + inset.left;
    CGFloat originY = CGRectGetMinY(rect) + inset.top;
    CGFloat width = CGRectGetWidth(rect) - inset.left - inset.right;
    CGFloat height = CGRectGetHeight(rect) - inset.top - inset.bottom;
    return CGRectMake(originX, originY, width, height);
}


@implementation HYTextField
/// 控制placeHolder 的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectFromInset(bounds, self.contentInset);
}
/// 控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectFromInset(bounds, self.contentInset);
}

@end
