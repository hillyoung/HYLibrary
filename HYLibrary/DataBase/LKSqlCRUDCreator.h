//
//  LKSqlCRUDCreator.h
//  LiemsMobileEnterprise
//
//  Created by young on 2017/7/12.
//  Copyright © 2017年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  可以构造sql语句的协议：实现此协议则可以直接使用
 */
@protocol LKSqlCRUDCreatorProtocol <NSObject>

@property (copy, nonatomic) NSString *primaryKey ;   //主键
@property (copy, nonatomic) NSString *condition ;   //查询时的约束条件

@end

/**
 *  可用于构造sql的行集对象的基类
 */
@interface LKSqlRowsetBaseEntity<LKSqlCRUDCreatorProtocol> : NSObject

@end

/**
 *  简单的sql的构造器:用于批量构造“简单sql语句”
 */
@interface LKSqlCRUDCreator : NSObject

+ (NSString *)sqlForInsertWithEntities:(NSArray<id<LKSqlCRUDCreatorProtocol>> *)entities ;

+ (NSString *)sqlForDeleteWithEntities:(NSArray<id<LKSqlCRUDCreatorProtocol>> *)entities ;

+ (NSString *)sqlForUpdateWithEntities:(NSArray<id<LKSqlCRUDCreatorProtocol>> *)entities ;

+ (NSString *)sqlForQueryWithEntity:(id<LKSqlCRUDCreatorProtocol>)entity ;

@end
