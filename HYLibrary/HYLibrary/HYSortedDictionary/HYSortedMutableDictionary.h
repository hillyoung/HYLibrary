//
//  HYSortedMutableDictionary.h
//  eStyle
//
//  Created by luculent on 16/8/24.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 继承于NSMutableDictionary，有一个数组属性，用以保存“添加的键值对”的顺序
 * 使用setValue或setObject来添加元素
 */
@interface HYSortedMutableDictionary : NSMutableDictionary

//记录key的添加顺序
@property (strong, nonatomic) NSMutableArray *insertKeyArray;

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey ;

@end
