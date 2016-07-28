//
//  HYMetadataViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/30.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseTableViewController.h"

typedef void(^MetadataSelectedBlock)(NSString *title, NSString *value);

/**
 *  元数据的基类
 */
//@interface BaseMetadata : NSObject
//
//@property (copy, nonatomic) NSString *name;
//@property (copy, nonatomic) NSString *value;
//
//- (instancetype)initWithName:(NSString *)name value:(NSString *)value ;
//
//@end

/**
 *  基本元数据的选取， 如机组，部门等
 */
@interface HYMetadataViewController : HYBaseTableViewController

/**
 *   title为名称,value为主键
 */
@property (copy, nonatomic) void(^selectedMetadataBlock)(NSString *title, NSString *value);

+ (instancetype)selectedMetadataFromViewController:(UIViewController *)viewController dataList:(NSMutableArray *)dataList completion:(MetadataSelectedBlock)completion ;

@end
