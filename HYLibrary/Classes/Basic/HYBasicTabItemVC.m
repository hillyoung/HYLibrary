//
//  HYBasicTabItemVC.m
//  HYLibrary
//
//  Created by 杨小山 on 2024/1/16.
//

#import "HYBasicTabItemVC.h"
#import "Masonry.h"


@interface HYTabBar : UIView
@property (nonatomic, strong) UITabBar *innerTabbar;     /**< 自带的tabbar */
@end

@implementation HYTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.innerTabbar = [UITabBar new];
    [self addSubview:self.innerTabbar];
    [self.innerTabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.width.equalTo(self);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self);
        }
    }];
}

@end





@interface HYBasicTabItemVC () <UITabBarDelegate>
@property (nonatomic, strong) HYTabBar *tabbar;
@end

@implementation HYBasicTabItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabbar = [HYTabBar new];
    self.tabbar.innerTabbar.delegate = self;
//    self.tabbar.translatesAutoresizingMaskIntoConstraints = NO;
    self.tabbar.backgroundColor = [UIColor orangeColor];
//    self.tabbar.items = self.tabBarController.tabBar.items;
    
    
    [self.view addSubview:self.tabbar];
    [self.tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.bottom.equalTo(self.view);
//        }
    }];
    
//    [tabContent addSubview:self.tabbar];
//    [self.tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.centerX.width.equalTo(tabContent);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(tabContent.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.bottom.equalTo(tabContent);
//        }
//    }];
    
    NSMutableArray *items = [NSMutableArray array];
    [self.tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:idx];
//        item.title = obj.title;
//        item.image = obj.image;
        [items addObject:item];
    }];
    self.tabbar.innerTabbar.items = items;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)reloadTabbar {
    NSUInteger index = self.tabBarController.selectedIndex;
    NSArray *items = self.tabbar.innerTabbar.items;
    if(index < items.count) {
        UITabBarItem *item = [items objectAtIndex:index];
//        [self.tabbar.innerTabbar setSelectedItem:<#(UITabBarItem * _Nullable)#>]
    }
}


#pragma mark -- UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    BOOL shouldSelected = YES;
    NSUInteger index = [self.tabbar.innerTabbar.items indexOfObject:item];
    UIViewController *vc = [self.tabBarController.viewControllers objectAtIndex:index];

    if([self.tabBarController.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        shouldSelected = [self.tabBarController.delegate tabBarController:self.tabBarController shouldSelectViewController:vc];
    }
    
    if(shouldSelected) {
        [self.tabBarController setSelectedViewController:vc];
//        if([self.tabBarController.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
//            [self.tabBarController.delegate tabBarController:self.tabBarController didSelectViewController:vc];
//        }
    }
}

@end
