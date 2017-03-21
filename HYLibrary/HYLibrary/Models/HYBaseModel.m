//
//  HYBaseModel.m
//  MDPMS
//
//  Created by luculent on 16/6/24.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseModel.h"

@implementation HYBaseMetadata

- (instancetype)initWithName:(NSString *)name value:(NSString *)value {
    if (self = [super init]) {
        _name = name;
        _value = value;
    }
    
    return self;
}

@end


@implementation HYVCConfigModel

- (instancetype)initWithstoryName:(NSString *)storyName
              viewControllerClass:(NSString *)viewControllerClass {
    
    
    if (self = [super init]) {
        self.storyName = storyName;
        self.viewControllerClass = viewControllerClass;
    }
    
    return self;
}

#pragma mark - Message

- (UIViewController *)viewController {
    
    if (self.storyName.length) {
        return self.viewControllerClass.length? [[UIStoryboard storyboardWithName:self.storyName bundle:nil] instantiateViewControllerWithIdentifier:self.viewControllerClass]:[[UIStoryboard storyboardWithName:self.storyName bundle:nil] instantiateInitialViewController];
    } else if (self.viewControllerClass.length) {
       return [[NSClassFromString(self.viewControllerClass) alloc] init];
    }
    
    return [[UIViewController alloc] init];
}

@end


@implementation BeginEndTime

@end
