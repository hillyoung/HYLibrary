//
//  UINavigationController+Utility.m
//  SimpleTool
//
//  Created by hillyoung on 2020/12/22.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import "UINavigationController+Utility.h"
#import <objc/runtime.h>


@interface UIBarButtonItem ()

@property (nonatomic, copy) void (^actionBlock)(UIBarButtonItem *barItem);

@end

@implementation UIBarButtonItem (Utility)

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void (^)(UIBarButtonItem *barItem))actionBlock {
    if (self = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(actionBlockAction)]) {
        self.actionBlock = actionBlock;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title actionBlock:(void (^)(UIBarButtonItem *barItem))actionBlock {
    if (self = [self initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(actionBlockAction)]) {
        self.actionBlock = actionBlock;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image actionBlock:(void (^)(UIBarButtonItem * _Nonnull))actionBlock {
    if (self = [self initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(actionBlockAction)]) {
        self.actionBlock = actionBlock;
    }
    return self;
}

- (void)actionBlockAction {
    self.actionBlock ? self.actionBlock(self):nil;
}

NSString *actionBlockKey = @"actionBlock";
- (void)setActionBlock:(void (^)(UIBarButtonItem *))actionBlock {
    [self willChangeValueForKey:actionBlockKey];
    objc_setAssociatedObject(self, [actionBlockKey UTF8String], actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:actionBlockKey];
}

- (void (^)(UIBarButtonItem *))actionBlock {
    return objc_getAssociatedObject(self, [actionBlockKey UTF8String]);
}

@end

@implementation UINavigationController (Utility)

@end
