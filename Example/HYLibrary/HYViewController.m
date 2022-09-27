//
//  HYViewController.m
//  HYLibrary
//
//  Created by hillyoung on 05/22/2022.
//  Copyright (c) 2022 hillyoung. All rights reserved.
//

#import "HYViewController.h"
#import <HYLibrary/HYLibrary.h>
#import <YYModel/YYModel.h>
#import <Masonry/Masonry.h>



@interface CXWSettingPreferenceActionCell : UITableViewCell<HYFormCellConfigProtocol>
@property (nonatomic, strong) UILabel *titleL;      /**< 标题控件  */
@property (nonatomic, strong) UILabel *valueL;      /**< 内容控件 */
@property (nonatomic, strong) UIImageView *accessoryIconV;      /**< 箭头控件 */
@end

@implementation CXWSettingPreferenceActionCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.separatorInset = UIEdgeInsetsZero;
    self.titleL = [UILabel new];
    self.tintColor = [UIColor redColor];
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
    self.valueL = [UILabel new];
    [self.contentView addSubview:self.valueL];
    [self.valueL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL.mas_right).offset(8);
        make.centerY.equalTo(self.titleL);
    }];
    
    self.accessoryIconV = [UIImageView new];
    [self.contentView addSubview:self.accessoryIconV];
    [self.accessoryIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.valueL.mas_right).offset(4);
        make.centerY.equalTo(self.titleL);
        make.right.equalTo(self.contentView).offset(-16);
        make.size.equalTo(@24);
    }];
}

- (void)update:(HYFormRowDataSource *)datasource {
    self.titleL.text = datasource.title;
    self.valueL.text = datasource.value;
}

@end



@interface CXWSettingPreferenceSwitchCell : UITableViewCell <HYFormCellConfigProtocol>
@property (nonatomic, strong) UILabel *titleL;      /**< 标题控件 */
@property (nonatomic, strong) UILabel *detailL;     /**< 详情控件 */
@property (nonatomic, strong) UISwitch *switchC;        /**< 开关控件 */
@end

@implementation CXWSettingPreferenceSwitchCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.separatorInset = UIEdgeInsetsZero;
    self.titleL = [UILabel new];
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(16);
    }];
    
    self.detailL = [UILabel new];
    [self.contentView addSubview:self.detailL];
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).offset(4);
        make.left.equalTo(self.titleL);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
    self.switchC = [UISwitch new];
    [self.switchC addTarget:self action:@selector(changeStatusAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchC];
    [self.switchC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailL.mas_right).offset(8);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-18);
    }];
}

- (void)update:(HYFormRowDataSource *)datasource {
    self.delegate = datasource.delegate;
    self.titleL.text = datasource.title;
    self.detailL.text = datasource.placeholder;
    self.switchC.on = [datasource.value boolValue];
}

- (void)changeStatusAction:(UISwitch *)control {
    if([self.delegate respondsToSelector:@selector(cell:didChangeValue:)]) {
        [self.delegate cell:self didChangeValue:@(control.on)];
    }
}

@end


@interface HYViewController ()
@property (nonatomic, strong) HYTableViewFormDelegate *viewDelegate;    /**< 代理对象 */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HYViewController


- (instancetype)init {
    if (self = [super init]) {
        _viewDelegate = [HYTableViewFormDelegate new];
        [self initDatasource];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"");
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if(self = [super initWithCoder:coder]) {
        _viewDelegate = [HYTableViewFormDelegate new];
        [self initDatasource];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (@available(iOS 15.0, *)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    self.tableView.delegate = self.viewDelegate;
    self.tableView.dataSource = self.viewDelegate;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:CXWSettingPreferenceSwitchCell.class forCellReuseIdentifier:@"HYViewCell"];
    self.tableView.rowHeight = 56.0;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    self.tableView.separatorColor = [UIColor colorWithHexString:@"E5E5E5"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)initDatasource {
    NSArray *part1Array = @[
        @{
            @"identifier":@"CXWSettingPreferenceActionCell",
            @"title":@"默认轨迹",
            @"target": self,
            @"value":@"当前航次",
            @"selector":@"chooseDefaultTravelIntervalAtIndexPath:"
        },@{
            @"identifier":@"CXWSettingPreferenceActionCell",
            @"title":@"搜索框位置",
            @"target": self,
            @"value":@"底部",
            @"selector":@"chooseDefaultTravelIntervalAtIndexPath:"
        }
    ];
    
    NSArray *part2Array = @[
        @{
            @"identifier":@"CXWSettingPreferenceSwitchCell",
            @"title":@"国旗显示",
            @"placeholder":@"开启后，国旗出现在船名前面",
            @"target": self,
            @"value":@YES,
            @"delegate": self,
            @"selector": @"changeNationalVisibleAtIndexPath:"
        },@{
            @"identifier":@"CXWSettingPreferenceSwitchCell",
            @"title":@"定位标使用头像",
            @"placeholder":@"开启后，头像出现在定位标上",
            @"target": self,
            @"value":@NO,
            @"delegate": self,
            @"selector": @"changeNationalVisibleAtIndexPath:"
        }
    ];

    // 单元格按照高保真分成四块：由于业务较简单，此处使用数组嵌套构造数据源，最外层数组对应显示区域；第二层数组对应
    // 区域中需要显示的项目
    
    HYFormSectionDataSource *group1 = [HYFormSectionDataSource new];
    group1.rows = (id)[NSMutableArray yy_modelArrayWithClass:HYFormRowDataSource.class json:part1Array];
    group1.height = 1;
    HYFormSectionDataSource *group2 = [HYFormSectionDataSource new];
    group2.rows = (id)[NSMutableArray yy_modelArrayWithClass:HYFormRowDataSource.class json:part2Array];
    group2.height = 8;
    self.viewDelegate.groups = @[
        group1,
        group2
    ];
}

- (void)chooseDefaultTravelIntervalAtIndexPath:(NSIndexPath *)indexPath {
    [self presentViewController:[HYViewController new] animated:YES completion:nil];
    return;
    HYFormSectionDataSource *sectionM = [self.viewDelegate.groups objectAtIndex:indexPath.section];
    HYFormRowDataSource *rowM = [sectionM.rows objectAtIndex:indexPath.row];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)changeNationalVisibleAtIndexPath:(NSIndexPath *)indexPath {
    HYFormSectionDataSource *sectionM = [self.viewDelegate.groups objectAtIndex:indexPath.section];
    HYFormRowDataSource *rowM = [sectionM.rows objectAtIndex:indexPath.row];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark -- HYFormCellDelegate

- (void)cell:(UITableViewCell<HYFormCellConfigProtocol> *)cell didChangeValue:(id)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    HYFormSectionDataSource *sectionM = [self.viewDelegate.groups objectAtIndex:indexPath.section];
    HYFormRowDataSource *rowM = [sectionM.rows objectAtIndex:indexPath.row];
    rowM.value = value;
}


@end
