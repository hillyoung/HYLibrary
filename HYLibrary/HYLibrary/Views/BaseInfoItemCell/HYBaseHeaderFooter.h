//
//  HYBaseHeaderFooter.h
//  MDPMS
//
//  Created by luculent on 16/6/28.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBaseHeaderFooter : UITableViewHeaderFooterView

@property (strong, nonatomic) UIColor *titleColor ;

@property (strong, nonatomic) UIColor *detailColor ;

@property (strong, nonatomic) UILabel *titleLabel ;

@property (strong, nonatomic) UIButton *detailButton ;

@property (copy, nonatomic) void(^detailButtonTapBlock)(HYBaseHeaderFooter *headerFooter);

- (void)updateWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle ;

@end
