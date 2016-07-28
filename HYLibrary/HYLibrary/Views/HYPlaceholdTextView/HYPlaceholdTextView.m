//
//  HYPlaceholdTextView.m
//  PlaceholdTextView
//
//  Created by yanghaha on 15/7/27.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import "HYPlaceholdTextView.h"

#define HY_TEXTVIEW_TEXT @"text"

@interface HYPlaceholdTextView ()

@property (nonatomic, strong) UILabel *placeholdLabel;
@property (nonatomic, strong) UILabel *wordCountLabel;

@end

@implementation HYPlaceholdTextView
@synthesize titleColor = _titleColor;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeText)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect rect = self.frame;
    CGFloat originX = self.labelOriginX;
    CGFloat originY = self.labelOriginY;
    CGFloat width = CGRectGetWidth(rect)-2*self.labelOriginX;

    self.placeholdLabel.font = self.placeholdFont? self.placeholdFont:self.font;

    CGFloat height = [self.placehold boundingRectWithSize:CGSizeMake(width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholdLabel.font} context:nil].size.height;
    self.placeholdLabel.frame = CGRectMake(originX, originY, width, height);

    originY = CGRectGetHeight(rect)-originY-self.font.pointSize;
    self.wordCountLabel.frame = CGRectMake(originX, originY, width, self.font.pointSize);
    self.wordCountLabel.hidden = !self.wordCount;
    self.wordCountLabel.font = self.font;
    [self didChangeText];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeText)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

#pragma mark - Private

- (void)changeWordCount {
    self.wordCountLabel.text = [@(self.text.length).stringValue stringByAppendingFormat:@"/%d", (int)self.wordCount];
}

#pragma mark - Set&&Get

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor lightGrayColor];
    }
    
    return _titleColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.placeholdLabel.textColor = _titleColor;
}

- (UILabel *)placeholdLabel {
    if (!_placeholdLabel) {
        _placeholdLabel = [[UILabel alloc] init];
        _placeholdLabel.textColor = [UIColor grayColor];
        _placeholdLabel.numberOfLines = 0;
        _placeholdLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _placeholdLabel.textColor = self.titleColor;
        [self addSubview:_placeholdLabel];
    }

    return _placeholdLabel;
}

- (UILabel *)wordCountLabel {
    if (!_wordCountLabel) {
        _wordCountLabel = [[UILabel alloc] init];
        _wordCountLabel.textColor = [UIColor grayColor];
        _wordCountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_wordCountLabel];
    }

    return _wordCountLabel;
}

- (void)setPlacehold:(NSString *)placehold {
    _placehold = placehold;

    CGRect rect = self.placeholdLabel.frame;
    CGFloat height = [self.placehold boundingRectWithSize:CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.height;
    self.placeholdLabel.text = _placehold;
    rect.size.height = height;
    self.placeholdLabel.frame = rect;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholdLabel.font = font;
    self.wordCountLabel.font = font;
}

- (UIFont *)font {
    UIFont *font = [super font];
    if (!font) {
        font = [UIFont systemFontOfSize:14];
    }

    return font;
}


- (void)setText:(NSString *)text {
    [super setText:text];

    [self didChangeText];
}

#pragma mark - Action

- (void)didChangeText {
    self.placeholdLabel.hidden = self.text.length;

    if (self.text.length > self.wordCount && self.wordCount) {

        if (self.didExceedBlock) {
            NSString *text = self.didExceedBlock(self.text);
            NSAssert(text.length<=self.wordCount, @"处理后的字符串超过wordCount限制");
            self.text = text;
        } else {
            self.text = [self.text substringToIndex:self.wordCount];
        }
    }

    [self changeWordCount];
}

@end
