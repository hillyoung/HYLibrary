//
//  BaseInfoMultiCell.h
//  MDPMS
//
//  Created by luculent on 16/6/22.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseInfoMultiCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *infoLabel;

- (void)updateWithName:(NSString *)name info:(NSString *)info ;

@end


/**
 *  上面标题，下面内容
 */
@interface TBBaseInfoMultiCell : BaseInfoMultiCell

@end
