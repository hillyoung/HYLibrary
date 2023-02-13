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


@implementation UIViewController (Adapt)

- (void)setPopoverSourceView:(UIView *)sourceView targetView:(UIView *)targetView arrowDirection:(UIPopoverArrowDirection)arrowDirection {
    CGRect frame;
    if(targetView.superview == sourceView) {
        frame = targetView.frame;
    } else {
        frame = [targetView convertRect:targetView.frame toView:sourceView];
    }

    self.popoverPresentationController.permittedArrowDirections = arrowDirection;
    self.popoverPresentationController.sourceView = sourceView;
    self.popoverPresentationController.sourceRect = frame;
}

- (void)setPopoverSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect arrowDirection:(UIPopoverArrowDirection)arrowDirection {
    self.popoverPresentationController.permittedArrowDirections = arrowDirection;
    self.popoverPresentationController.sourceView = sourceView;
    self.popoverPresentationController.sourceRect = sourceRect;
}

@end
