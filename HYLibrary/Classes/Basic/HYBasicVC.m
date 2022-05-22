//
//  HYBasicVC.m
//  FBSnapshotTestCase
//
//  Created by 杨小山 on 2022/5/22.
//

#import "HYBasicVC.h"


@interface HYBasicVC ()

@end

@implementation HYBasicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (![gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) return YES;
    
    UIScreenEdgePanGestureRecognizer *recognizer = (UIScreenEdgePanGestureRecognizer *)gestureRecognizer;
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1) {
        return [self sideGestureEnable:recognizer];
    }
    return NO;
}

// 控制当前页面是否可以策划返回，如果禁止测滑返回，子类重写控制
- (BOOL)sideGestureEnable:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
