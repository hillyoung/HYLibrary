//
//  HYFormInputCell.m
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import "HYFormInputCell.h"
#import "HYLibrary_Private.h"

void(^setTitleForLabel)(UILabel *, NSString *) = ^(UILabel *label, NSString *title) {
    CGFloat labelWidth = kTitleLabelWidth;
    CGFloat spaceCount = title.length - 1;   // 标题文字间的间隔数量
    NSDictionary *attributes = @{
        NSFontAttributeName:label.font,
        NSForegroundColorAttributeName:label.textColor
    };
    CGSize size = [title boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    CGFloat margin = (labelWidth - size.width) / spaceCount;
    NSNumber*number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString* attribute = [[NSMutableAttributedString alloc] initWithString:title attributes:attributes];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, spaceCount)];
    
    if (title.length > 1) {
        label.attributedText = attribute;
    } else {
        label.text = title;
    }
};


@interface HYFormInputCell ()
@property (nonatomic, strong) UILabel *titleLabel;          /**< 标题控件 */
@property (nonatomic, strong) UITextField *inputField;       /**< 输入框 */
@end

@implementation HYFormInputCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.height.greaterThanOrEqualTo(@(14));
        make.width.equalTo(@(kTitleLabelWidth));
        make.leading.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
    self.inputField = [UITextField new];
    [self.inputField addTarget:self action:@selector(inputChangeText:) forControlEvents:UIControlEventEditingChanged];
    [self.inputField addTarget:self action:@selector(inputEditingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    [self.inputField setContentHuggingPriority:199 forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(8);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.height.equalTo(self.contentView).offset(-16);
    }];
}

- (void)update:(HYFormRowDataSource *)datasource {
    self.inputField.text = datasource.value;
    self.inputField.secureTextEntry = datasource.secreted;
    self.inputField.placeholder = datasource.placeholder;
    self.inputField.keyboardType = datasource.keyboardType;
    setTitleForLabel(self.titleLabel, datasource.title);
}

- (void)inputChangeText:(UITextField *)textFiled {
    if ([self.delegate respondsToSelector:@selector(cell:didChangeValue:)]) {
        [self.delegate cell:self didChangeValue:textFiled.text];
    }
}

- (void)inputEditingDidEnd {
    if ([self.delegate respondsToSelector:@selector(didEndEditingInCell:)]) {
        [self.delegate didEndEditingInCell:self];
    }
}

@end


@interface HYFormFullInputCell ()
@property (nonatomic, strong) UITextField *inputField;       /**< 输入框 */
@end

@implementation HYFormFullInputCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.inputField = [UITextField new];
    [self.inputField addTarget:self action:@selector(inputChangeText:) forControlEvents:UIControlEventEditingChanged];
    [self.inputField setContentHuggingPriority:199 forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.height.greaterThanOrEqualTo(@(28));
    }];
}

- (void)update:(HYFormRowDataSource *)datasource {
    self.inputField.text = datasource.value;
    self.inputField.secureTextEntry = datasource.secreted;
    self.inputField.placeholder = datasource.placeholder;
    self.inputField.keyboardType = datasource.keyboardType;
}

- (void)inputChangeText:(UITextField *)textFiled {
    if ([self.delegate respondsToSelector:@selector(cell:didChangeValue:)]) {
        [self.delegate cell:self didChangeValue:textFiled.text];
    }
}

@end



@interface HYFormVerifyCodeCell ()
@property (nonatomic, strong) UILabel *titleLabel;          /**< 标题控件 */
@property (nonatomic, strong) UITextField *inputField;       /**< 输入框 */
@property (nonatomic, strong) UIButton *verifyBtn;      /**< 获取验证码按钮 */
@end

@implementation HYFormVerifyCodeCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.height.greaterThanOrEqualTo(@(14));
        make.width.equalTo(@(kTitleLabelWidth));
        make.leading.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
    self.inputField = [UITextField new];
    [self.inputField addTarget:self action:@selector(inputChangeText:) forControlEvents:UIControlEventEditingChanged];
    [self.inputField setContentHuggingPriority:199 forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(8);
        make.height.equalTo(self.contentView).offset(-16);
    }];
    
    self.verifyBtn = [UIButton new];
    self.verifyBtn.layer.cornerRadius = 6.0;
    self.verifyBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 8, 6, 8);
    self.verifyBtn.backgroundColor = [UIColor colorWithHexString:@"3BA1F5"];
    [self.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.verifyBtn addTarget:self action:@selector(verifyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.verifyBtn];
    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inputField.mas_trailing).offset(8);
        make.centerY.equalTo(self.inputField);
        make.trailing.equalTo(self.contentView).offset(-16);
    }];
}

- (void)update:(HYFormRowDataSource *)datasource {

    self.inputField.text = datasource.value;
    self.inputField.placeholder = datasource.placeholder;
    self.inputField.keyboardType = datasource.keyboardType;
    setTitleForLabel(self.titleLabel, datasource.title);
    if ([datasource.label intValue] > 0) {
        [self.verifyBtn setTitle:[NSString stringWithFormat:@"%@S", datasource.label] forState:UIControlStateNormal];
        self.verifyBtn.enabled = NO;
        self.verifyBtn.alpha = 0.8;
    } else {
        [self.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.verifyBtn.enabled = YES;
        self.verifyBtn.alpha = 1.0;
    }
}

- (void)inputChangeText:(UITextField *)textFiled {
    
    if ([self.delegate respondsToSelector:@selector(cell:didChangeValue:)]) {
        [self.delegate cell:self didChangeValue:textFiled.text];
    }
}

- (void)verifyBtnAction {
    SEL selector = NSSelectorFromString(@"didTapVerifyButtonIncell:");
    NSMethodSignature *signature = [self.delegate methodSignatureForSelector:selector];
    if (signature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = self.delegate;
        invocation.selector = selector;
        [invocation setArgument:(void *)(&self) atIndex:2];
        [invocation invoke];
    }
}

@end


@implementation HYFormActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)update:(HYFormRowDataSource *)datasource {
    self.textLabel.text = datasource.title;
}

@end
