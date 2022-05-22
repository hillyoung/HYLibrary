//
//  HYFloatingView.m
//  SimpleTool
//
//  Created by 杨小山 on 2022/4/17.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import "HYFloatingView.h"
#import "Masonry.h"


@implementation HYFloatingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}

- (void)showInView:(UIView *)superView {
    if (self.superview) {
        [self removeFromSuperview];
    }
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.trailing.equalTo(superView);
    }];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.superview];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.superview).offset(MIN(MAX(point.y, 0), CGRectGetHeight((self.superview).bounds) - CGRectGetHeight(self.bounds)));
            if (point.x > CGRectGetMidX((self.superview).bounds)) {
                make.trailing.equalTo(self.superview);
            } else {
                make.leading.equalTo(self.superview);
            }
        }];
        [self.superview layoutIfNeeded];
    } completion:nil];
}

@end
