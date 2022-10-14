//
//  HYFormInputCell.h
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFormCellProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface HYFormInputCell : UITableViewCell <HYFormCellConfigProtocol>

@end


@interface HYFormFullInputCell : UITableViewCell <HYFormCellConfigProtocol>

@end


/// 输入验证码单元格
@interface HYFormVerifyCodeCell : UITableViewCell <HYFormCellConfigProtocol>

@end


@interface HYFormActionCell : UITableViewCell <HYFormCellConfigProtocol>
@end


@interface HYEmptyCell : UITableViewCell <HYFormCellConfigProtocol>
@end

NS_ASSUME_NONNULL_END
