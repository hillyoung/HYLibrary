//
//  HYBaseHeaderFooter.m
//  MDPMS
//
//  Created by luculent on 16/6/28.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseHeaderFooter.h"

@implementation HYBaseHeaderFooter
@synthesize titleColor = _titleColor;
@synthesize detailColor = _detailColor;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }

    return self;
}

#pragma mark - Setter && Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = self.titleColor;
    }

    return _titleLabel;
}

- (UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [[UIButton alloc] init];
        _detailButton.backgroundColor = [UIColor clearColor];
        _detailButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_detailButton addTarget:self action:@selector(detailButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _detailButton;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor lightGrayColor];
    }
    
    return _titleColor;
}

- (void)setDetailColor:(UIColor *)detailColor {
    _detailColor = detailColor;
    
    [self.detailButton setTitleColor:_detailColor forState:UIControlStateNormal];
}

- (UIColor *)detailColor {
    if (!_detailColor) {
        _detailColor = [UIColor lightGrayColor];
    }
    
    return _detailColor;
}

#pragma mark - Private

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailButton];
    
    [self updateTitleLabel];
    [self updateDetailButton];
}

- (void)updateTitleLabel {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.titleLabel.font.pointSize);
        make.leading.equalTo(self.mas_leading).offset(15);
        make.width.mas_greaterThanOrEqualTo(80);
    }];
}

- (void)updateDetailButton {
    [self.detailButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(self.detailButton.titleLabel.font.pointSize);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
}

#pragma mark - Action

- (void)detailButtonAction {
    if (self.detailButtonTapBlock) {
        self.detailButtonTapBlock(self);
    }
}

#pragma mark - Message

- (void)updateWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle {
    self.titleLabel.text = title;
    [self.detailButton setTitle:detailTitle forState:UIControlStateNormal];
}

@end
