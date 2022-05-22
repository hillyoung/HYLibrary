//
//  UIImage+HYLibrary.h
//  MDPMS
//
//  Created by luculent on 16/6/20.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HYLibrary)

/**
 *  通过缩略图字符串获取对应的缩略图
 */
+ (UIImage *)imageFromString:(NSString *)thumbnail ;

/**
 通过视频的本地地址，获取视频缩略图
 */
+(UIImage *)thumbImageWithVideoFileUrl:(NSString *)videoURL ;

@end
