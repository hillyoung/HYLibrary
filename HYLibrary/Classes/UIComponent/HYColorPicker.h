//
//  HYColorPicker.h
//  SimpleTool
//
//  Created by 杨小山 on 2022/4/17.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBasicAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@class HYColorPicker;
@protocol HYColorPickerDelegate <NSObject>

- (void)colorPicker:(HYColorPicker *)picker didChangeColor:(UIColor *)color ;

@end

@interface HYColorPicker : HYBasicAlertView
@property (nonatomic, weak) id<HYColorPickerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
