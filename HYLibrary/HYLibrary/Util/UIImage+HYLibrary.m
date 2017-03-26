//
//  UIImage+HYLibrary.m
//  MDPMS
//
//  Created by luculent on 16/6/20.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "UIImage+HYLibrary.h"

@implementation UIImage (HYLibrary)

+ (UIImage *)imageFromString:(NSString *)thumbnail {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:thumbnail options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [UIImage imageWithData:data];
}

@end
