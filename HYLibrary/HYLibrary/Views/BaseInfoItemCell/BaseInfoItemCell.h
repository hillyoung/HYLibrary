//
//  BaseInfoItemCell.h
//  MDPMS
//
//  Created by luculent on 16/6/13.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface HYBaseInfoCellModel : BaseInfoItem
//
//@property (strong, nonatomic) NSString *cellIdentifier;
//
//- (instancetype)initWithTitle:(NSString *)title content:(id)content cellIdentifier:(NSString *)cellIdentifier ;
//
//@end

@interface BaseInfoItemCell : UITableViewCell

@property (strong, nonatomic, readonly) HYLRTitleTextField *infoTextField;

- (void)updateWithTitle:(NSString *)title content:(NSString *)content ;

@end
