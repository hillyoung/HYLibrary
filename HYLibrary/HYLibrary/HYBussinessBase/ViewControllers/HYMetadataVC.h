//
//  HYMetadataViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/30.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYTableBaseVC.h"

typedef void(^MetadataSelectedBlock)(NSString *title, NSString *value);

/**
 *  元数据的基类
 */
@interface HYBaseMetadata : NSObject

@property (copy, nonatomic) NSString *name; //名称：页面显示的内容
@property (copy, nonatomic) NSString *value;  //实际值："页面显示的内容"对应的需要传入到后台的实际值

- (instancetype)initWithName:(NSString *)name value:(NSString *)value ;

@end


/**
 *  基本元数据的选取， 如键值对的形式
 */
@interface HYMetadataVC : HYTableBaseVC

/**
 *   title为名称,value为主键
 */
@property (copy, nonatomic) void(^selectedMetadataBlock)(NSString *name, NSString *value);

+ (instancetype)selectedMetadataFromViewController:(UIViewController *)viewController dataList:(NSMutableArray *)dataList completion:(MetadataSelectedBlock)completion ;

@end
