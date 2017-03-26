//
//  UIViewController+HYLibrary.m
//  MDPMS
//
//  Created by luculent on 16/6/15.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "UIViewController+HYLibrary.h"

@implementation UIView (HYLibrary)

- (void)setupUI {
    
}

@end

@implementation UIViewController (HYLibrary)

- (BOOL)isVisible {
    return self.isViewLoaded && self.view.window;
}

- (void)setupUI {

}

@end
