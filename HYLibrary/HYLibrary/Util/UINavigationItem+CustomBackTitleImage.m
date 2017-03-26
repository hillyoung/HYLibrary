//
//  UINavigationItem+NoBackTitle.m
//  navigationTitle
//
//  Created by luculent on 16/4/19.
//  Copyright © 2016年 luculent. All rights reserved.
//

#import "UINavigationItem+CustomBackTitleImage.h"
#import <objc/runtime.h>


static NSString *itemTitle;
@implementation UINavigationItem (CustomBackTitleImage)

#pragma mark - LifeCycle

- (void)dealloc {
    objc_removeAssociatedObjects(self);
}

#pragma mark - Setter && Getter

static char kCustomBackItemKey;

/**
 *  解决不能在VC中设置返回按钮title的问题，
 *
 *  @return 如果VC中设置了返回按钮，如果未设置返回title为空的默认返回按钮
 */
- (UIBarButtonItem *)customBackButtonItem {
    UIBarButtonItem *item = [self customBackButtonItem];
    if (item) {
        return item;
    }
    item = objc_getAssociatedObject(self, &kCustomBackItemKey);

    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        objc_setAssociatedObject(self, &kCustomBackItemKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return item;
}

#pragma mark - Message

+ (void)exchangeBetweenBackItemWithCustomBackItemUsedTitle:(NSString *)title {
    [UINavigationItem exchangeBetweenBackItemWithCustomBackItemUsedTitle:title image:nil];
}

+ (void)exchangeBetweenBackItemWithCustomBackItemUsedTitle:(NSString *)title image:(UIImage *)image {
    static dispatch_once_t onceToken;
    
    itemTitle = title;
    [[UINavigationBar appearance] setBackIndicatorImage:image];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
    
    
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self, @selector(backBarButtonItem));
        Method targetMethod = class_getInstanceMethod(self, @selector(customBackButtonItem));
        method_exchangeImplementations(originMethod, targetMethod);
    });
}

@end
