//
//  HYSortedMutableDictionary.m
//  eStyle
//
//  Created by luculent on 16/8/24.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYSortedMutableDictionary.h"

@implementation HYSortedMutableDictionary

//- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... {
//    if (self = [super init]) {
//        
//        va_list args;
//        va_start(args, firstObject);
//        NSString *key = nil;
//        for (NSString *str = firstObject; str != nil; str = va_arg(args,NSString*))
//        {
//            if (!key) {
//                key = str;
//            } else {
//                [self setValue:str forKey:key];
//                key = nil;
//            }
//        }
//        va_end(args);
//    }
//    
//    return self;
//}

- (instancetype)initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    if (self = [super initWithObjects:objects forKeys:keys count:cnt]) {
        
    }
    
    return self;
}

- (NSUInteger)count {
    return self.insertKeyArray.count;
}

- (id)objectForKey:(id)aKey {
    return nil;
}

- (NSEnumerator *)keyEnumerator {
    return nil;
}

#pragma mark - Setter && Getter

- (NSMutableArray *)insertKeyArray {
    if (!_insertKeyArray) {
        _insertKeyArray = [NSMutableArray array];
    }
    
    return _insertKeyArray;
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    [super setObject:anObject forKey:aKey];
    
    if (anObject &&
        aKey) {
        [self.insertKeyArray addObject:aKey];
    }
}

- (void)removeObjectForKey:(id)aKey {
//    [super removeObjectForKey:aKey];
    [self.insertKeyArray removeObject:aKey];
}



- (void)removeAllObjects {
    [super removeAllObjects];
    [self.insertKeyArray removeAllObjects];
}

@end
