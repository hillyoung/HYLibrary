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
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.numberOfLines = 0;
        _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _infoLabel;
}

#pragma mark - Private

- (void)setupUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.infoLabel];

    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16]];
    [self.nameLabel addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeWidth toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:85]];
    [self.nameLabel addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:17]];

    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeLeading toItem:self.nameLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:5]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeBottom toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10]];
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
    
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16]];
    [self.nameLabel addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeWidth toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:85]];
    [self.nameLabel addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:17]];


    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeTop toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeLeading toItem:self.nameLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoLabel attribute:NSLayoutAttributeBottom toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10]];
}

@end
