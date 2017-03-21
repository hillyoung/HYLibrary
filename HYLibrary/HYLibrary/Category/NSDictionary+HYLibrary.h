//
//  NSDictionary+HYLibrary.h
//  fhln2
//
//  Created by luculent on 16/8/23.
//  Copyright © 2016年 Hitoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Ordinal)

//记录key的添加顺序
@property (strong, nonatomic) NSMutableArray *insertKeyArray;

/**
 *  添加键值对
 */
- (void)hy_setValue:(id)value forKey:(NSString *)key;

/**
 *  添加键值对
 */
- (void)hy_setObject:(id)object forKey:(NSString *)key;

/**
 *  移除指定的key对应的value
 */
- (void)hy_removeObjectForKey:(id)aKey;

- (void)hy_removeAllObjects;

@end
