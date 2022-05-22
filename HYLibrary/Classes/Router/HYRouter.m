//
//  SDRouter.m
//  SimpleTool
//
//  Created by 2 on 2020/9/15.
//  Copyright © 2020 hillyoung. All rights reserved.
//

#import "HYRouter.h"
#include <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>


@implementation HYRouter

+ (void)getMemberOfClass:(Class)class completion:(void (^)(NSArray<Class> * _Nonnull))completion {
        
    unsigned int count;
    const char **classes;
    Dl_info info;

    dladdr(&_MH_EXECUTE_SYM, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &count);
    
    // 判断class1是否为class2的子类
    BOOL(^isKindClassBlock)(Class class1, Class class2) = ^(Class class1, Class class2){
        Class r0 = [class1 class];
        while (1) {
            
            if (r0 == 0) {
                return NO;
            }else{
                if (r0 != class2) {
                    r0 = [r0 superclass];
                }else{
                    return YES;
                }
            }
        }
    };

    NSMutableArray *classArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
      Class tempClass = NSClassFromString ([NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding]);
        if (isKindClassBlock(tempClass, class)) {  // 判断是不是传入的class的子类
            [classArray addObject:tempClass];
        }
//        NSLog(@"Class name: %@", NSStringFromClass(class_getSuperclass(tempClass)));
    }
    free(classes);  //解决objc_copyClassNamesForImage导致的内存泄露
    completion ? completion([classArray copy]):nil;
}

+ (id)objectForPath:(NSString *)path withUserInfo:(NSDictionary *)userInfo {
    NSString *urlStr = [[[HYRouterProducer shareProducer] absoluteURLForPath:path] absoluteString];
    return [self objectForURL:urlStr withUserInfo:userInfo];
}

+ (void)openPath:(NSString *)path withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id _Nonnull))completion {
    NSString *urlStr = [[[HYRouterProducer shareProducer] absoluteURLForPath:path] absoluteString];
    [self openURL:urlStr withUserInfo:userInfo completion:completion];
}

+ (void)loadPath:(NSString *)path withUserInfo:(NSDictionary *)userInfo completion:(nonnull void (^)(UIViewController *_Nonnull object))completion {
    NSString *urlStr = [[[HYRouterProducer shareProducer] absoluteURLForPath:path] absoluteString];
    id object = [super objectForURL:urlStr withUserInfo:userInfo];
    [object setValuesForKeysWithDictionary:userInfo];
    completion ? completion(object):nil;
}


@end
