//
//  HYScanningViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/27.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYScanningViewController.h"

@interface HYScanningViewController ()

@property (strong, nonatomic) HYScanningView *scanningView;

@end

@implementation HYScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    //    [self.scanningView startScanning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scanningView stopScanning];
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

- (HYScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[HYScanningView alloc] init];
        _scanningView.frame = [UIScreen mainScreen].bounds;
        _scanningView.type = HYScanningViewTypeQR;
        _scanningView.delegate = self;
        _scanningView.cornerView.lineWidth = 5;
        _scanningView.cornerView.cornerLength = 20;
        
        CGSize size = CGSizeMake(200, 200);
        _scanningView.boxFrame = CGRectMake((CGRectGetWidth(_scanningView.frame)-size.width)/2, 100, size.width, size.height);
        _scanningView.scanningLineColor = [UIColor greenColor];
        _scanningView.cornerColor = [UIColor greenColor];
    }
    
    return _scanningView;
}

#pragma mark - Private

- (void)setupUI {
    [self.view addSubview:self.scanningView];
}

#pragma mark - HYScanningViewDelegate

- (void)scanningView:(HYScanningView *)scanningView didFinishScanCode:(NSString *)content {

}


@end
