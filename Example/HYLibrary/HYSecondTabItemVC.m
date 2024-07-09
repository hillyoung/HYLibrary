//
//  HYSecondTabItemVC.m
//  HYLibrary_Example
//
//  Created by 杨小山 on 2024/1/16.
//  Copyright © 2024 hillyoung. All rights reserved.
//

#import "HYSecondTabItemVC.h"


@interface HYSecondTabItemVC () <CAAnimationDelegate>
@property (nonatomic, strong) UIView *dotV; /**< 点 */
@property (nonatomic, strong) CAShapeLayer *animationLayer;   /**< 轨迹动画 */
@end

@implementation HYSecondTabItemVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 40)];
    [btn setTitle:@"动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(animationFirstAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.dotV = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 10, 10)];
    self.dotV.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.dotV];
}

- (void)animationFirstAction {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 150, 150, 100, 0, M_PI*2, false);
    CGRect rect = CGPathGetBoundingBox(path);
    CGRect pathRect = CGPathGetPathBoundingBox(path);
    CGFloat value = sqrt(4.0);
    [self beginAnimation:0.2];
}

- (void)beginAnimation:(CGFloat)progress {
    
    CAShapeLayer *shape=[CAShapeLayer layer];
    shape.frame = self.view.bounds;
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(100, 200)];
    [bezierPath addLineToPoint:CGPointMake(300, 400)];

    shape.lineWidth=2;
    shape.fillColor=[UIColor clearColor].CGColor;
    shape.strokeColor=[UIColor greenColor].CGColor;
    shape.lineCap = kCALineCapRound;
    shape.lineJoin = kCALineJoinRound;
    shape.path=bezierPath.CGPath;
    
//    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    positionAnimation.path = bezierPath.CGPath;
//    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
//    transformAnimation.values = angles;
//    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
//    animationGroup.animations = @[positionAnimation, transformAnimation];
//    animationGroup.duration = 6.0f;
//    CAShapeLayer *arrowL = [CAShapeLayer new];
//    arrowL.bounds = CGRectMake(0, 0, kNumFrom375(30), kNumFrom375(30));
//    arrowL.contents = (__bridge id)([UIImage imageNamed:@"voyage_track_arrow"].CGImage);
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 6.0f;
    checkAnimation.beginTime = CACurrentMediaTime() - progress * checkAnimation.duration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    checkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [shape addAnimation:checkAnimation forKey:@"forecast"];
    self.animationLayer = shape;
//    [arrowL addAnimation:animationGroup forKey:@"forecast"];
//    [shape addSublayer:arrowL];
    
    [self.view.layer addSublayer:shape];
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:self.dotV.layer.position];
//    [path addLineToPoint:(CGPoint){300, 300}];
//    
//    animation.path = path.CGPath;
//    
//    animation.duration = 5;
//    animation.beginTime = CACurrentMediaTime() - progress * animation.duration;
//    animation.autoreverses = NO;
//    animation.removedOnCompletion = NO;
//    animation.speed = 1.0;
//    animation.timeOffset = 100.0;
    
    // _label is just a UILabel in a storyboard
//    [self.dotV.layer addAnimation:animation forKey:@"LabelPathAnimation"];

}

#pragma mark -- CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self.animationLayer removeFromSuperlayer];
    }
}

@end
