//
//  HYBasicAlertView.m
//  SimpleTool
//
//  Created by 2 on 2020/9/29.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import "HYBasicAlertView.h"

@interface HYBasicAlertView () <CAAnimationDelegate>

@end

@implementation HYBasicAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.enableBackdropDismiss = YES;
        [self setupBackgroundView];
        [self setupContentView];
    }
    return self;
}

- (void)setupBackgroundView {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.backgroundView = [UIImageView new];
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.backgroundView.userInteractionEnabled = self.enableBackdropDismiss;
    [self.backgroundView addGestureRecognizer:tap];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
}

- (void)setupContentView {
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 6.0;
     [self addSubview:self.contentView];
     [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self);
         make.centerY.equalTo(self).priority(100);
     }];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    [self showInView:view animated:animated completion:nil];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated completion:(nullable void (^)(void))completion {
    
    UIView *inView = view ? :[[UIApplication sharedApplication] keyWindow];
    [inView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(inView).insets(UIEdgeInsetsZero);
    }];
    
    if (animated) {
        __block MASConstraint *constraint = nil;
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            constraint = make.top.equalTo(self.bottom).priority(101);
        }];

        start = CACurrentMediaTime();
        self.layer.opacity = 0;
        [UIView animateWithDuration:0.3 animations:^{   // 添加整个alertView的动画
            self.layer.opacity = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{   // 添加contentviewt从底部弹出的动画
                [constraint uninstall];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                completion ? completion():nil;
            }];
        }];
    } else {
        completion ? completion():nil;
    }
}

CFAbsoluteTime start;
- (void)stopAnimation {
              // CFAbsoluteTime end = CACurrentMediaTime();
                // CFAbsoluteTime space = end - start;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
                // CFAbsoluteTime end = CACurrentMediaTime();
                // CFAbsoluteTime space = end - start;
}


- (CABasicAnimation *)getAnimationKeyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue{
   CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    basicAnimation.fromValue = fromValue;
    /*byvalue是在fromvalue的值的基础上增加量*/
    // basicAnimation.byValue = @1;
    basicAnimation.toValue = toValue;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;
    basicAnimation.duration = 0.3;
//    basicAnimation.repeatCount = 1;
    /* animation remove from view after animation finish */
    basicAnimation.removedOnCompletion = YES;
    return basicAnimation;
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion {
    
    void(^block)(void) = ^{
        [self removeFromSuperview];
        completion ? completion():nil;
    };
    
    if (animated) {
        [self.contentView removeFromSuperview]; // 解决设置self.layer.opacity会导致离屏渲染的问题
        self.layer.opacity = 1;
        [UIView animateWithDuration:0.3 animations:^{   // 添加移除动画
            self.layer.opacity = 0;
        } completion:^(BOOL finished) {
            block();
        }];
    } else {
        block();
    }
}

- (void)tapAction {
    [self dismissAnimated:YES completion:self.backdropDismissBlock];
}

- (void)setEnableBackdropDismiss:(BOOL)enableBackdropDismiss {
    _enableBackdropDismiss = enableBackdropDismiss;
    self.backgroundView.userInteractionEnabled = enableBackdropDismiss;
}

@end
