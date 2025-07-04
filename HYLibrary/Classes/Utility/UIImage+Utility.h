//
//  UIImage+Utility.h
//  SimpleTool
//
//  Created by 2 on 2020/9/29.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utility)


/// 通过指定尺寸、颜色生成图片
/// @param size 尺寸
/// @param radius 圆角
/// @param backColor 背景色
+ (UIImage *)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor ;
/// 通过制定尺寸、颜色生成图片
/// @param size <#size description#>
/// @param radius <#radius description#>
/// @param backColor <#backColor description#>
/// @param completion <#completion description#>
+ (void)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor completion:(void(^)(UIImage *image))completion ;

+ (void)imageWihtSize:(CGSize)size radius:(CGFloat)radius title:(NSString *)title titleAttribute:(NSDictionary *)attribute backColor:(UIColor *)backColor completion:(void(^)(UIImage *image))completion ;

/// 获取指定区域的图片
/// @param rect 指定区域
- (UIImage *)imageAtRect:(CGRect)rect ;
/// 水平方向渐变色的图片
/// @param colors 颜色数组
/// @param imgSize 图片尺寸
+ (instancetype)horizontalImageFromColors:(NSArray*)colors imgSize:(CGSize)imgSize ;

/// 垂直方向将变色的图片
/// @param colors 颜色数组
/// @param imgSize 图片尺寸
+ (instancetype)verticalImageFromColors:(NSArray*)colors imgSize:(CGSize)imgSize ;

@end


@interface UIImage (Compress)

/// 压缩图片到指定大小以下
/// - Parameter maxFileSize: 指定大小
- (NSData *)compressToMaxFileSizeData:(NSInteger)maxFileSize ;

@end


NS_ASSUME_NONNULL_END
