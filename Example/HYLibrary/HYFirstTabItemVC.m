//
//  HYFirstTabItemVC.m
//  HYLibrary_Example
//
//  Created by 杨小山 on 2024/1/16.
//  Copyright © 2024 hillyoung. All rights reserved.
//

#import "HYFirstTabItemVC.h"

@interface HYFirstTabItemVC ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation HYFirstTabItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 350, 200, 200)];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageView];
}

- (void)buttonAction {
    NSLog(@"");
    
    
    [self customImage];
}


- (void)customImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddRect(ctx, CGRectMake(0, 0, 50, 50));
    CGContextMoveToPoint(ctx, 0, 50);
    CGContextAddLineToPoint(ctx, 100, 50);
    CGContextSetLineWidth(ctx, 1.0);
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
    
    
    CGContextSetLineWidth(ctx, 0.3);
    CGContextMoveToPoint(ctx, 0, 60);
    CGContextAddLineToPoint(ctx, 100, 60);
    CGContextStrokePath(ctx);


    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = image;
}

@end
