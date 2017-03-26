//
//  PHAsset+HYLoadLocalSource.m
//  MWPhotoBrowser
//
//  Created by yanghaha on 16/7/17.
//  Copyright © 2016年 Michael Waterfall. All rights reserved.
//

#import "PHAsset+HYLoadLocalSource.h"

@implementation PHAsset (HYLoadLocalSource)

#pragma mark - Private

+ (NSArray *)performLoadAssets {

    // Initialise
    NSMutableArray *assets = [NSMutableArray new];
    // Load
    if (NSClassFromString(@"PHAsset")) {
        // Photos library iOS >= 8
        PHFetchOptions *options = [PHFetchOptions new];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
        [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [assets addObject:obj];
        }];
    }

    return [assets copy];
}

- (void)getImageInfoInCompletion:(void(^)(NSData *imageData, NSString *fileName))completion {

    __block NSData *data;
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:self] firstObject];
    if (self.mediaType == PHAssetMediaTypeImage) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:self
                                                          options:options
                                                    resultHandler:
         ^(NSData *imageData,
           NSString *dataUTI,
           UIImageOrientation orientation,
           NSDictionary *info) {
             data = [NSData dataWithData:imageData];
         }];
    }

    if (data.length <= 0) {
        completion(nil, nil);
    } else {
        completion(data, resource.originalFilename);
    }
}

- (void)getVideoAudioInfoInCompletion:(void(^)(NSString *filePath, NSString *fileName))completion {

    NSArray *assetResources = [PHAssetResource assetResourcesForAsset:self];
    PHAssetResource *resource;

    for (PHAssetResource *assetRes in assetResources) {
        if (assetRes.type == PHAssetResourceTypePairedVideo ||
            assetRes.type == PHAssetResourceTypeVideo) {
            resource = assetRes;
        }
    }
    NSString *fileName = @"assetVideoTemp.mov";
    if (resource.originalFilename) {
        fileName = resource.originalFilename;
    }

    if (self.mediaType == PHAssetMediaTypeVideo || self.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHVideoRequestOptionsVersionOriginal;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeFastFormat;

        //缓存到沙盒中路径，
        NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:tempPath error:nil];
        
        //压缩视频并存到沙盒中
        [[PHImageManager defaultManager] requestAVAssetForVideo:self options:options resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
            
            NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
            AVAssetExportSession *exportSession = nil;
            
            NSString *preset = nil;
            
            //获取支持的分辨率,仅列举其中几种
            if ([compatiblePresets containsObject:AVAssetExportPreset640x480]) {
                preset = AVAssetExportPreset640x480;
            } else if ([compatiblePresets containsObject:AVAssetExportPreset1280x720]) {
                preset = AVAssetExportPreset1280x720;
            } else {
                preset = AVAssetExportPresetAppleM4A;
            }
            
            exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:preset];
            exportSession.outputFileType = AVFileTypeMPEG4;
            exportSession.outputURL = [NSURL fileURLWithPath:tempPath];
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                        completion(tempPath, fileName);
                    }
                });
            }];
        }];
        
    } else {
        completion(nil, nil);
    }
}

#pragma mark - Message

+ (void)loadAssets:(void(^)(NSArray<PHAsset *> *))completion {

    __block NSArray *array = nil;
        // Check library permissions
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                array = [PHAsset performLoadAssets];
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        array = [PHAsset performLoadAssets];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        completion(array);
    });
}

- (void)getMediaInfoInCompletion:(void (^)(id data, NSString *fileName))completion {

    /**
     *  避免浪费系统资源
     */
    if (!completion) {
        return;
    }

    if (self.mediaType == PHAssetMediaTypeImage) {
        [self getImageInfoInCompletion:^(NSData *imageData, NSString *fileName) {
            completion(imageData, fileName);
        }];
    } else {
        [self getVideoAudioInfoInCompletion:^(NSString *filePath, NSString *fileName) {
            completion(filePath, fileName);
        }];
    }
}


@end
