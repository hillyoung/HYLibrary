//
//  CALayer+Utility.m
//  SimpleTool
//
//  Created by hillyoung on 2022/1/7.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import "CALayer+Utility.h"

@implementation CALayer (Utility)

- (UIColor *)colorInPoint:(CGPoint)point {
    UInt8 *pixel = malloc(4 * sizeof(UInt8));
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 8, colorSapce, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0 ];
    free(pixel);
    return color;
}

- (UIImage *)imageAtRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)getImageWithCompletion:(void (^)(UIImage * _Nonnull))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self imageAtRect:self.bounds];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion ? completion(image):nil;
        });
    });
}

@end
