//
//  LKDBManager.h
//  LiemsMobileEnterprise
//
//  Created by young on 2017/7/12.
//  Copyright © 2017年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface LKDBManager : NSObject


@property (copy, nonatomic) NSString *path; //db的路径

@property (strong, nonatomic) FMDatabase *database; //数据库实例



@end
