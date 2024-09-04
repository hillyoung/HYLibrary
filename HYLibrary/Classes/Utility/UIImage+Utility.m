//
//  UIImage+Utility.m
//  SimpleTool
//
//  Created by 2 on 2020/9/29.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

+ (void)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor completion:(void(^)(UIImage *image))completion{
    [self imageWihtSize:size radius:radius title:@"" titleAttribute:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]} backColor:backColor completion:completion];
}

+ (void)imageWihtSize:(CGSize)size radius:(CGFloat)radius title:(NSString *)title titleAttribute:(NSDictionary *)attribute backColor:(UIColor *)backColor completion:(void (^)(UIImage * _Nonnull))completion {
    // 异步绘制裁切
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 利用绘图建立上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        [path addClip];
        [backColor setFill];
        UIRectFill(rect);

        //计算文字所占的size,文字居中显示在画布上
        CGSize textSize = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attribute context:nil].size;
        CGFloat width = size.width;
        CGFloat height = size.height;
        CGRect newRect = CGRectMake((width - textSize.width)/2.0, (height - textSize.height)/2.0, textSize.width, textSize.height);
        [title drawInRect:newRect withAttributes:attribute];
        
        // 获取结果
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(resultImage);
        });
    });
}

- (UIImage *)imageAtRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

+ (instancetype)horizontalImageFromColors:(NSArray*)colors imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0, imgSize.height/2.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height/2.0);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)verticalImageFromColors:(NSArray *)colors imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(imgSize.width/2.0, 0);
    CGPoint end = CGPointMake(imgSize.width/2.0, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end


@implementation UIImage (Compress)

- (NSData *)compressToMaxFileSizeData:(NSInteger)maxFileSize {
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    if(!imageData) {
        imageData = UIImagePNGRepresentation(self);
    }
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    
    return imageData;
}

@end
