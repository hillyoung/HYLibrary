//
//  BaseInfoItemCell.m
//  MDPMS
//
//  Created by luculent on 16/6/13.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "BaseInfoItemCell.h"



//@implementation HYBaseInfoCellModel
//
//- (instancetype)initWithTitle:(NSString *)title content:(id)content cellIdentifier:(NSString *)cellIdentifier {
//    if (self = [super initWithTitle:title content:content]) {
//        _cellIdentifier = cellIdentifier;
//    }
//
//    return self;
//}
//
//@end

@interface BaseInfoItemCell ()

@property (strong, nonatomic) HYLRTitleTextField *infoTextField;

@end

@implementation BaseInfoItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    
}

#pragma mark - Setter && Getter

- (HYLRTitleTextField *)infoTextField {
    if (!_infoTextField) {
        _infoTextField = [[HYLRTitleTextField alloc] init];
        _infoTextField.borderStyle = UITextBorderStyleNone;
        _infoTextField.titleAlignment = NSTextAlignmentLeft;
        _infoTextField.titleColor = [UIColor lightGrayColor];
    }

    return _infoTextField;
}

#pragma mark - Private

- (void)setupUI {
    [self addSubview:self.infoTextField];
    
    CGFloat gap = 10;
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.leading.equalTo(self.mas_leading).offset(gap);
        make.trailing.equalTo(self.mas_trailing).offset(-gap);
    }];
}

#pragma mark - Message

- (void)updateWithTitle:(NSString *)title content:(NSString *)content {
    self.infoTextField.title = title.length? title:@" ";
    self.infoTextField.text = content;
}


@end
