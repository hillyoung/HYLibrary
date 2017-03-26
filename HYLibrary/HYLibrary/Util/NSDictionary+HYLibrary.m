//
//  NSDictionary+HYLibrary.m
//  fhln2
//
//  Created by luculent on 16/8/23.
//  Copyright © 2016年 Hitoo. All rights reserved.
//

#import "NSDictionary+HYLibrary.h"

@implementation NSMutableDictionary (Ordinal)

#pragma mark - Setter && Getter

- (void)setInsertKeyArray:(NSMutableArray *)insertKeyArray {
    objc_setAssociatedObject(self, @"insertKeyArray", insertKeyArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)insertKeyArray {
    
    NSMutableArray *array = objc_getAssociatedObject(self, @"insertKeyArray");
    
    if (!array) {
        array = [NSMutableArray array];
        self.insertKeyArray = array;
    }
    
    return array;
}

- (void)hy_setValue:(id)value forKey:(NSString *)key {
    [self setValue:value forKey:key];
    
    if (value &&
        key) {
        [self.insertKeyArray addObject:key];
    }
}

- (void)hy_setObject:(id)object forKey:(NSString *)key {
    [self setObject:object forKey:key];
    
    if (object &&
        key) {
        [self.insertKeyArray addObject:key];
    }
}

- (void)hy_removeObjectForKey:(id)aKey {
    [self removeObjectForKey:aKey];
    
    if (aKey) {
        [self.insertKeyArray removeObject:aKey];
    }
}

- (void)hy_removeAllObjects {
    [self removeAllObjects];
    [self.insertKeyArray removeAllObjects];
}

@end
