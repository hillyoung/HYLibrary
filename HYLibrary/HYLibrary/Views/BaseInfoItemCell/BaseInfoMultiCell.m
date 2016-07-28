//
//  BaseInfoMultiCell.m
//  MDPMS
//
//  Created by luculent on 16/6/22.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "BaseInfoMultiCell.h"

@implementation BaseInfoMultiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
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

#pragma mark - Setter && Getter

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.numberOfLines = 0;
    }

    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.numberOfLines = 0;
    }
    
    return _infoLabel;
}

#pragma mark - Private

- (void)setupUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.infoLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(17);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.leading.equalTo(self.nameLabel.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

#pragma mark - Message

- (void)updateWithName:(NSString *)name info:(NSString *)info {
    self.nameLabel.text = name;
    self.infoLabel.text = info;
}

@end

@implementation TBBaseInfoMultiCell

- (void)setupUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.infoLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(17);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.nameLabel.mas_leading);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

@end
