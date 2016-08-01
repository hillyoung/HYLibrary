//
//  HYActionSheet.h
//  MDPMS
//
//  Created by luculent on 16/6/16.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYActionSheet;

@protocol HYActionSheetDataSource <NSObject>

@optional

- (NSUInteger)numberOfOptionsActionSheet:(HYActionSheet *)actionSheet ;

- (NSString *)actionSheet:(HYActionSheet *)actionSheet titleForOptionAtIndex:(NSUInteger)index ;

@end

@protocol HYActionSheetDelegate <NSObject>

- (void)actionSheet:(HYActionSheet *)actionSheet didSelectedAtIndex:(NSUInteger)index ;

@end

@interface HYActionSheet : UIView

@property (weak, nonatomic) id<HYActionSheetDataSource> dataSource;
@property (weak, nonatomic) id<HYActionSheetDelegate> delegate;

- (void)showWithTitle:(NSString *)title message:(NSString *)message ;

@end
