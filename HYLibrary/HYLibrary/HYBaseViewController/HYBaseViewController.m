//
//  HYBaseViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/3.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()

@end

@implementation HYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatasource];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
