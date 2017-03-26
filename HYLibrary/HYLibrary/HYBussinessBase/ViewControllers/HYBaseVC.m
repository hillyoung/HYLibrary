//
//  HYBaseViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/3.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseVC.h"

@implementation HYVCConfigModel

- (instancetype)initWithstoryName:(NSString *)storyName
              viewControllerClass:(NSString *)viewControllerClass {


    if (self = [super init]) {
        self.storyName = storyName;
        self.viewControllerClass = viewControllerClass;
    }

    return self;
}

#pragma mark - Message

- (UIViewController *)viewController {

    UIViewController *vc = nil;

    if (self.storyName.length) {

        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:self.storyName bundle:nil];

        if (self.storyBoardID.length) {
            vc = [storyBoard instantiateViewControllerWithIdentifier:self.storyBoardID];
        } else {
            vc = [storyBoard instantiateInitialViewController];
        }

    } else if (self.viewControllerClass.length) {
        vc = [[NSClassFromString(self.viewControllerClass) alloc] init];
    }

    return vc;
}

@end


@interface HYBaseVC ()

@end

@implementation HYBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter && Getter

#pragma mark - Message

- (void)initDatasource {

};

- (void)updateDatasource {

};

- (void)updateDatasource:(id)data {
    
}

- (void)setupLeftItemWithTitle:(NSString *)title {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = item;
    _leftItem = item;
}

- (void)setupLeftItemWithImage:(UIImage *)image {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = item;
    _leftItem = item;
}

- (void)setupLeftItems:(NSArray *)items {
    self.navigationItem.leftBarButtonItems = items;
    _leftItems = items;
}

- (void)setupRightItemWithTitle:(NSString *)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = item;
    _rightItem = item;
}

- (void)setupRightItemWithImage:(UIImage *)image {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = item;
    _rightItem = item;
}

- (void)setupRightItems:(NSArray *)items {
    self.navigationItem.rightBarButtonItems = items;
    _rightItems = items;
}

- (void)leftItemAction {
    
}

- (void)rightItemAction {
    
}

- (void)popOrDismiss {
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
