//
//  HYBaseModel.h
//  MDPMS
//
//  Created by luculent on 16/6/24.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseMetadata : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *value;

- (instancetype)initWithName:(NSString *)name value:(NSString *)value ;
@end

/**
 *  创建UIViewController的数据源
 */
@interface HYVCConfigModel : NSObject

/**
 *  如果UIViewController是从storyboard加载UIViewController，
 *  那么此属性为storyboard的名字
 */
@property (copy, nonatomic) NSString *storyName ;

/**
 *  如果UIViewController是从storyboard加载UIViewController，
 *  那么此属性为storyboard中UIViewController的标识符，
 *  如果UIViewController是用代码来创建的，那么此属性为UIViewController的类名
 */
@property (copy, nonatomic) NSString *viewControllerClass ;


- (instancetype)initWithstoryName:(NSString *)storyName
              viewControllerClass:(NSString *)viewControllerClass ;

/**
 *  根据storyName和viewControllerClass来获取新建一个UIViewController
 */
- (UIViewController *)viewController ;

@end

@interface BeginEndTime : NSObject

@property (copy, nonatomic) NSString *beginTime ;
@property (copy, nonatomic) NSString *endTime ;

@end
