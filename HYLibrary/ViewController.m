//
//  ViewController.m
//  HYLibrary
//
//  Created by luculent on 16/7/28.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomView *view = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:view];
    
    NSString *urlStr = @"http://apis.baidu.com/heweather/weather/free";
    
    NSDictionary *params = @{@"city": @"beijing"};
    
    NSURLRequest *request = [[HYHttpCilent shareManager] textRequestWithHttpMethod:@"get" urlString:urlStr httpBody:params];
    
    [[HYHttpCilent shareManager] taskWithRequest:request success:^(NSURLResponse *response, id responseObject) {
        
        NSLog(@"请求成功");

        
    } failure:^(NSURLResponse *response, NSError *error) {
        
        NSLog(@"请求失败");

        
    } willFinishBlock:^(BOOL isSuccess) {
        
        NSLog(@"将要完成请求成功失败回调");
        
    } didFinishBlock:^(BOOL isSuccess) {
        NSLog(@"已经完成请求成功失败回调");
    }];;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource && UITabelViewDelege

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.row%2? @"cell1":@"cell"];
    
    UILabel *leftLabel = [cell.contentView viewWithTag:1];
    UILabel *rightLabel = [cell.contentView viewWithTag:2];
    leftLabel.text = @(indexPath.row).stringValue;
    rightLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

@end
