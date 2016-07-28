//
//  PHAsset+HYLoadLocalSource.h
//  MWPhotoBrowser
//
//  Created by yanghaha on 16/7/17.
//  Copyright © 2016年 Michael Waterfall. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (HYLoadLocalSource)

/**
 *  加载本地所有的视频，图片; 由于本地资源可能过多，建议在子线程中，调用此方法
 *
 *  @param completion 加载完成的回调
 */
+ (void)loadAssets:(void(^)(NSArray<PHAsset *> *))completion ;

/**
 *  获取asset中的图片或视频，如果上传的是视频，上传完，需要删除沙盒文件
 *
 *  @param completion 获取到信息的回调，
 *  data为[NSData class]时，表示为视频文件
 *  data为[NSString class]时，表示为图片文件
 */
- (void)getMediaInfoInCompletion:(void(^)(id data, NSString *fileName))completion ;

@end
