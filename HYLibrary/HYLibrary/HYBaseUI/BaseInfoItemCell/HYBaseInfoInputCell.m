//
//  HYBaseInfoInputCell.m
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseInfoInputCell.h"

float HYBaseInfoInputCell_GAP = 15.0;
float HYBaseInfoInputCell_GAP_V = 13;        //垂直方向的默认间隔
float HYBaseInfoInputCell_GAP_A = -5.0;        //到accessory的间隔

#pragma mark - HYBaseInfoInputCell------------------------------------------


@interface HYBaseInfoInputCell () <UITextFieldDelegate>

@property (strong, nonatomic) HYLRTitleTextField *infoTextField;
@property (strong, nonatomic) NSLayoutConstraint *infoTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *infoBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *infoTrailingConstraint;

@end

@implementation HYBaseInfoInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _gapToTop = _gapToBottom = -1;
        self.clipsToBounds = YES;
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

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor lightGrayColor];
    }
    
    return _titleColor;
}

- (HYLRTitleTextField *)infoTextField {
    if (!_infoTextField) {
        _infoTextField = [[HYLRTitleTextField alloc] init];
        _infoTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _infoTextField.borderStyle = UITextBorderStyleNone;
        _infoTextField.titleAlignment = NSTextAlignmentLeft;
        _infoTextField.titleColor = self.titleColor;
        _infoTextField.textAlignment = NSTextAlignmentRight;
        _infoTextField.delegate = self;
    }

    return _infoTextField;
}

- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        _accessoryImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _accessoryImageView.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAccessoryAction)];
        _accessoryImageView.userInteractionEnabled = YES;
        [_accessoryImageView addGestureRecognizer:tap];
    }
    
    return _accessoryImageView;
}
//
//- (void)setAccessoryImage:(UIImage *)accessoryImage {
//    self.accessoryImageView.image = accessoryImage;
//
////    if (accessoryImage) {
////        [self updateAccessoryImageView:HYBaseInfoInputCell_GAP widthMultipliedBy:.5];
////    } else {
////        [self updateAccessoryImageView:HYBaseInfoInputCell_GAP widthMultipliedBy:0];
////    }
//}

- (void)setGapToTop:(CGFloat)gapToTop{
    _gapToTop = gapToTop;

    self.infoTopConstraint.constant = _gapToTop;
}

- (CGFloat)gapToTop {
    if (_gapToTop < 0) {
        _gapToTop = HYBaseInfoInputCell_GAP_V;
    }
    
    return _gapToTop;
}

- (void)setGapToBottom:(CGFloat)gapToBottom {
    _gapToBottom = gapToBottom;

    self.infoBottomConstraint.constant = _gapToBottom;
}

- (CGFloat)gapToBottom {
    if (_gapToBottom < 0) {
        _gapToBottom = HYBaseInfoInputCell_GAP_V;
    }

    return _gapToBottom;
}

#pragma mark - Private

- (void)setupUI {
    
    [self.contentView addSubview:self.accessoryImageView];
    [self.contentView addSubview:self.infoTextField];

    [self updateAccessoryImageView:HYBaseInfoInputCell_GAP widthMultipliedBy:0.5];

    self.infoTopConstraint = [NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.gapToTop];
    [self.contentView addConstraint:self.infoTopConstraint];

    self.infoBottomConstraint = [NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeBottom toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-fabs(self.gapToBottom)];
    [self.contentView addConstraint:self.infoBottomConstraint];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:HYBaseInfoInputCell_GAP]];

    self.infoTrailingConstraint = [NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeTrailing toItem:self.accessoryImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:HYBaseInfoInputCell_GAP_A];
    [self.contentView addConstraint:self.infoTrailingConstraint];
}

- (void)updateAccessoryImageView:(CGFloat)gap widthMultipliedBy:(CGFloat)multipliedBy {

    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.accessoryImageView attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.accessoryImageView attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-gap]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.accessoryImageView attribute:NSLayoutAttributeBottom toItem:self.infoTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:HYBaseInfoInputCell_GAP_V]];
    [self.accessoryImageView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.accessoryImageView attribute:NSLayoutAttributeWidth toItem:self.accessoryImageView attribute:NSLayoutAttributeHeight multiplier:multipliedBy constant:0]];
}

#pragma mark - Action

- (void)tapAccessoryAction {
    if (self.accessoryTapBlock) {
        self.accessoryTapBlock(self);
    }
}

#pragma mark - Message

- (void)updateWithTitle:(NSString *)title
                content:(NSString *)content
              placehold:(NSString *)placehold
         accessoryImage:(UIImage *)accessoryImage {
    self.infoTextField.title = title.length? title:@" ";
    self.infoTextField.text = content;
    self.infoTextField.placeholder = placehold;
    self.accessoryImageView.image = accessoryImage;
    
    //cell重用导致无法自适应，添加的代码
    self.infoTextField.itemWidth = 0;
}

- (void)setAccessoryImageViewHidden:(BOOL)hidden {
    self.accessoryImageView.hidden = hidden;

    self.infoTrailingConstraint.constant = hidden? CGRectGetHeight(self.frame)/2.:HYBaseInfoInputCell_GAP_A;
}

#pragma mark - UITextFieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    
//    if (self.changeCharactersBlock) {
//        self.changeCharactersBlock(self);
//    }
//    
//    return YES;
//}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.changeCharactersBlock) {
        self.changeCharactersBlock(self, textField.text);
    }
    
    return YES;
}

@end

#pragma mark - HYAddImageCell------------------------------------------

@implementation HYImageItemModel

- (instancetype)initWithImage:(id)image name:(NSString *)name {
    if (self =[super init]) {
        _image = image;
        _name = name;
    }

    return self;
}

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name originUrlStr:(NSString *)originUrlStr {
    if (self = [super init]) {
        _image = image;
        _name = name;
        _originUrlStr = originUrlStr;
    }
    
    return self;
}

@end

float deleteButtonWidth = 25;   //删除按钮宽度

@interface HYAddImageCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIButton *deleteButton ;
@property (strong, nonatomic) UIImageView *imageView ;
@property (strong, nonatomic) UILabel *titleLabel ;

@end

@implementation HYAddImageCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

#pragma mark - Setter && Getter

- (UIButton *)deleteButton {
    if (!_deleteButton ) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = deleteButtonWidth/2.;
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"一" forState:UIControlStateNormal];
    }
    
    return _deleteButton ;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    
    return _titleLabel;
}

#pragma mark - Private

- (void)setupUI {

    [self.contentView addSubview:self.imageView];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.imageView attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.imageView attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.imageView attribute:NSLayoutAttributeBottom toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15]];

    [self.contentView addSubview:self.deleteButton];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.deleteButton attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.deleteButton attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.deleteButton addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.deleteButton attribute:NSLayoutAttributeWidth toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:deleteButtonWidth]];
    [self.deleteButton addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.deleteButton attribute:NSLayoutAttributeHeight toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:deleteButtonWidth]];

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:2]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.titleLabel addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:16]];
}


@end

#pragma mark - HYAddImageCell------------------------------------------

@interface HYAddImageCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    NSArray *_dataList ;    //左右的图片
}

@property (strong, nonatomic) UICollectionView *collectionView ;

@end

@implementation HYAddImageCell
@synthesize itemSize = _itemSize;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _edit = YES;
    }
    return self;
}

- (void)setupUI {
    [super setupUI];
    
    [self.collectionView registerClass:[HYAddImageCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([HYAddImageCollectionCell class])];
    [self.contentView addSubview:self.collectionView];

    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.contentView attribute:NSLayoutAttributeBottom toItem:self.infoTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:100]];
}

#pragma mark - Setter && Getter


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.itemSize;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    
    return _collectionView;
}

- (CGFloat)gapToBottom {
    if (_gapToBottom < 0) {
        _gapToBottom = 110;
    }
    
    return _gapToBottom;
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    
    [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setItemSize:_itemSize];
}

- (CGSize)itemSize {
    if (CGSizeEqualToSize(_itemSize, CGSizeZero)) {
        _gapToBottom = 44;
        _itemSize = CGSizeMake(90, 100);
    }
    
    return _itemSize;
}

#pragma mark - Action

- (void)deleteButtonAction:(UIButton *)button {
    
    if (!self.edit) {
        return;
    }
    
    if (self.deleteImageBlock) {
        self.deleteImageBlock(self, button.tag);
    }
}

#pragma mark - Message

- (void)updateWithImages:(NSArray<HYImageItemModel *> *)images {
    _dataList = images;

    self.gapToBottom = images.count? 110:HYBaseInfoInputCell_GAP_V;


    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeTop toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.gapToTop]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeBottom toItem:self.infoTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-fabs(self.gapToBottom)]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:HYBaseInfoInputCell_GAP]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.infoTextField attribute:NSLayoutAttributeTrailing toItem:self.accessoryImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:HYBaseInfoInputCell_GAP_A]];

    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYAddImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYAddImageCollectionCell class]) forIndexPath:indexPath];
    
    HYImageItemModel *item = _dataList[indexPath.row];
    cell.imageView.image = item.image;
    cell.titleLabel.text = item.name;
    cell.deleteButton.tag = indexPath.row;
    cell.deleteButton.hidden = !self.edit;
    [cell.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.toucheImageBlock) {
        self.toucheImageBlock(self, indexPath.row);
    }
}

@end


@interface HYBaseInfoMultiInputCell () <UITextViewDelegate>

@property (strong, nonatomic) HYPlaceholdTextView *inputTextView ;

@end

@implementation HYBaseInfoMultiInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _gapToTop = _gapToBottom = -1;
        [self setupUI];
    }
    
    return self;
}

#pragma mark - Setter && Getter

//- (UIColor *)titleColor {
//    if (!_titleColor) {
//        _titleColor = APP_COLOR_TEXT_GRAY;
//    }
//    
//    return _titleColor;
//}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:17];
    }
    
    return _titleFont;
}

- (void)setTextViewHeight:(CGFloat)textViewHeight {
    _textViewHeight = textViewHeight;
    
    [self updateTextView:_textViewHeight];
}

- (HYPlaceholdTextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [[HYPlaceholdTextView alloc] init];
        _inputTextView.labelOriginX = 5;
        _inputTextView.labelOriginY = 7;
//        _inputTextView.placeholdFont = [UIFont systemFontOfSize:16];
        _inputTextView.font = [UIFont systemFontOfSize:16];
        _inputTextView.delegate = self;
    }

    return _inputTextView;
}

- (CGFloat)gapToBottom {
    if (_gapToBottom < 0) {
        _gapToBottom = 105;
    }
    
    return _gapToBottom;
}

#pragma mark - Private

- (void)setupUI {
    
    [super setupUI];
    
    [self.contentView addSubview:self.inputTextView];

    [self updateTextView:90];
}

- (void)updateTextView:(CGFloat)height {
}


#pragma mark - Message

- (void)updateWithTitle:(NSString *)title
                content:(NSString *)content
              placehold:(NSString *)placehold {
    self.infoTextField.title = title;
    self.inputTextView.text = content;
    self.inputTextView.placehold = placehold;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (self.changeCharactersBlock) {
        self.changeCharactersBlock(self, textView.text);
    }
    
    return YES;
}

@end

#pragma mark - HYBaseImageTitleCell------------------------------------------

@interface HYBaseImageTitleCell ()

@property (strong, nonatomic) HYLRImageTextField *infoTextField;
@property (strong, nonatomic) UIImageView *accessoryImageView;
@property (strong, nonatomic) NSLayoutConstraint *infoTextTopConstraint;        //infotextField的顶部约束
@property (strong, nonatomic) NSLayoutConstraint *infoTextBottomConstraint;     //infotextField的底部约束

@end

@implementation HYBaseImageTitleCell
@synthesize gapToBottom = _gapToBottom;
@synthesize gapToTop = _gapToTop;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _gapToTop = _gapToBottom = -1;
        [self setupUI];
    }

    return self;
}

#pragma mark - Setter && Getter

- (HYLRImageTextField *)infoTextField {
    if (!_infoTextField) {
        _infoTextField = [[HYLRImageTextField alloc] init];
        _infoTextField.borderStyle = UITextBorderStyleNone;
        _infoTextField.textAlignment = NSTextAlignmentLeft;
        _infoTextField.imageView.contentMode = UIViewContentModeCenter;
    }

    return _infoTextField;
}

- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        _accessoryImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _accessoryImageView.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAccessoryAction)];
        _accessoryImageView.userInteractionEnabled = YES;
        [_accessoryImageView addGestureRecognizer:tap];
    }
    
    return _accessoryImageView;
}

- (void)setGapToTop:(CGFloat)gapToTop{
    _gapToTop = gapToTop;

    self.infoTextTopConstraint.constant = _gapToTop;
}

- (CGFloat)gapToTop {
    if (_gapToTop < 0) {
        _gapToTop = HYBaseInfoInputCell_GAP_V;
    }
    
    return _gapToTop;
}

- (void)setGapToBottom:(CGFloat)gapToBottom {
    _gapToBottom = gapToBottom;

    self.infoTextBottomConstraint.constant = _gapToBottom;
}

- (CGFloat)gapToBottom {
    if (_gapToBottom < 0) {
        _gapToBottom = HYBaseInfoInputCell_GAP_V;
    }
    
    return _gapToBottom;
}

#pragma mark - Private

- (void)setupUI {
    [self addSubview:self.infoTextField];
    [self addSubview:self.accessoryImageView];
    
    [self updateAccessoryImageView:HYBaseInfoInputCell_GAP widthMultipliedBy:0.5];
    [self updateInfoTextField];
}

- (void)updateAccessoryImageView:(CGFloat)gap widthMultipliedBy:(CGFloat)multipliedBy {

}

- (void)updateInfoTextField {
    NSAssert(0, @"请重写约束");
}

#pragma mark - Action

- (void)tapAccessoryAction {
    if (self.accessoryTapBlock) {
        self.accessoryTapBlock(self);
    }
}



- (void)updateWithImage:(UIImage *)image content:(NSString *)content placehold:(NSString *)placehold accessoryImage:(UIImage *)accessoryImage {
    self.infoTextField.image = image;
    self.infoTextField.itemWidth = image.size.width + fabs(HYBaseInfoInputCell_GAP_A)*2;
    self.infoTextField.text = content;
    self.infoTextField.placeholder = placehold;
    self.accessoryImageView.image = accessoryImage;
}

@end

#pragma mark - HYDoubleDateCell------------------------------------------

@interface HYDoubleDateCell () <UITextFieldDelegate>

@property (strong, nonatomic) UILabel *titleLabel ;

@property (strong, nonatomic) UIView *dateContentView ;
@property (strong, nonatomic) UILabel *middleLabel; //“至”

@property (strong, nonatomic) HYLRImageTextField *leftDateTextField ;
@property (strong, nonatomic) HYLRImageTextField *rightDateTextField ;

@end

@implementation HYDoubleDateCell
@synthesize gapToTop = _gapToTop;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _gapToTop = -1;
        [self setupUI];
    }
    
    return self;
}

#pragma mark - Setter && Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }

    return _titleLabel;
}

- (UIView *)dateContentView {
    if (!_dateContentView) {
        _dateContentView = [[UIView alloc] init];
        [_dateContentView addSubview:self.middleLabel];
        [_dateContentView addSubview:self.leftDateTextField];
        [_dateContentView addSubview:self.rightDateTextField];
    }

    return _dateContentView;
}

- (UILabel *)middleLabel {
    if (!_middleLabel) {
        _middleLabel = [[UILabel alloc] init];
        _middleLabel.textColor = [UIColor lightGrayColor];
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.font = [UIFont systemFontOfSize:14];
        _middleLabel.text = @"至";
    }

    return _middleLabel;
}

- (HYLRImageTextField *)leftDateTextField {
    if (!_leftDateTextField) {
        _leftDateTextField = [[HYLRImageTextField alloc] init];
        _leftDateTextField.style = HYLRTextFieldStyleRight;
        _leftDateTextField.textAlignment = NSTextAlignmentRight;
        _leftDateTextField.imageView.contentMode = UIViewContentModeCenter;
//        _leftDateTextField.font = [UIFont systemFontOfSize:10];
        _leftDateTextField.textColor = [UIColor darkGrayColor];
        _leftDateTextField.delegate = self;
        _leftDateTextField.editEnable = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstDateSelectedAction)];
        _leftDateTextField.imageView.userInteractionEnabled = YES;
        [_leftDateTextField.imageView addGestureRecognizer:tap];
    }
    
    return _leftDateTextField;
}

- (HYLRImageTextField *)rightDateTextField {
    if (!_rightDateTextField) {
        _rightDateTextField = [[HYLRImageTextField alloc] init];
        _rightDateTextField.style = HYLRTextFieldStyleRight;
        _rightDateTextField.textAlignment = NSTextAlignmentRight;
        _rightDateTextField.imageView.contentMode = UIViewContentModeCenter;
//        _rightDateTextField.font = [UIFont systemFontOfSize:10];
        _rightDateTextField.textColor = [UIColor darkGrayColor];
        _rightDateTextField.delegate = self;
        _rightDateTextField.editEnable = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondDateSeclectedAction)];
        _rightDateTextField.imageView.userInteractionEnabled = YES;
        [_rightDateTextField.imageView addGestureRecognizer:tap];
    }

    return _rightDateTextField;
}


- (void)setGapToTop:(CGFloat)gapToTop{
    _gapToTop = gapToTop;
    
    NSAssert(0, @"请重写约束");
}

- (CGFloat)gapToTop {
    if (_gapToTop < 0) {
        _gapToTop = HYBaseInfoInputCell_GAP_V;
    }
    
    return _gapToTop;
}

#pragma mark - Private

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.dateContentView];

    [self updateTitleLabel];
    [self updateDateContentView];
}

- (void)updateTitleLabel {
    NSAssert(0, @"请重写约束");
}

- (void)updateDateContentView {
    NSAssert(0, @"请重写约束");
}

#pragma mark - Action

- (void)firstDateSelectedAction {
    if (self.firstDateBlock) {
        self.firstDateBlock(self);
    }
}

- (void)secondDateSeclectedAction {
    if (self.secondDateBlock) {
        self.secondDateBlock(self);
    }
}

#pragma mark - Message

- (void)updateWithTitle:(NSString *)title
              firstDate:(NSString *)firstDate
             firstImage:(UIImage *)firstImage
             secondDate:(NSString *)secondDate
            secondImage:(UIImage *)secondImage {
    self.titleLabel.text = title;
    self.leftDateTextField.text = firstDate;
    self.leftDateTextField.image = firstImage;
    self.leftDateTextField.itemWidth = firstImage.size.width;
    self.rightDateTextField.text = secondDate;
    self.rightDateTextField.image = secondImage;
    self.rightDateTextField.itemWidth = secondImage.size.width;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end

