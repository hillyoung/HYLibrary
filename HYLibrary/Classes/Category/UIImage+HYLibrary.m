//
//  UIImage+HYLibrary.m
//  MDPMS
//
//  Created by luculent on 16/6/20.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "UIImage+HYLibrary.h"
@import AVFoundation;

@implementation UIImage (HYLibrary)

+ (UIImage *)imageFromString:(NSString *)thumbnail {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:thumbnail options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [UIImage imageWithData:data];
}

+(UIImage *)thumbImageWithVideoFileUrl:(NSString *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

@end
