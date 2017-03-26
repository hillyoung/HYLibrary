//
//  HYMetadataViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/30.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYMetadataVC.h"

@implementation HYBaseMetadata

- (instancetype)initWithName:(NSString *)name value:(NSString *)value {
    if (self = [super init]) {
        _name = name;
        _value = value;
    }

    return self;
}

@end


@interface HYMetadataVC () {
    NSIndexPath *_selectedIndex ;   //记录选中的行
}

@end

@implementation HYMetadataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerCellClass:[UITableViewCell class]];
    [self.tableView setEditing:YES animated:YES];
    [self.tableView setAllowsMultipleSelectionDuringEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)rightItemAction {
    
    [self leftItemAction];
    
    HYBaseMetadata *item = self.dataList[_selectedIndex.row];
    if (self.selectedMetadataBlock) {
        self.selectedMetadataBlock(item.name, item.value);
    }
}

#pragma mark - Action

- (void)leftItemAction {
    [self popOrDismiss];
}

#pragma mark - Message

+ (instancetype)selectedMetadataFromViewController:(UIViewController *)viewController dataList:(NSMutableArray *)dataList completion:(MetadataSelectedBlock)completion {
    
    HYMetadataVC *VC = [[HYMetadataVC alloc] init];
    VC.dataList = dataList;
    VC.selectedMetadataBlock = completion;
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController pushViewController:VC animated:YES];
    } else {
        
        UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftItemAction)];
        [VC setupLeftItems:@[dismissButton]];
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:VC];
        [viewController presentViewController:navigation animated:YES completion:nil];
    }
    
    return VC;
}

#pragma mark - UITableViewDatasource && UITabelViewDelege


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    HYBaseMetadata *item = self.dataList[indexPath.row];
    
    cell.textLabel.text = item.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self leftItemAction];
    
    HYBaseMetadata *item = self.dataList[indexPath.row];
    if (self.selectedMetadataBlock) {
        self.selectedMetadataBlock(item.name, item.value);
    }
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.indexPathsForSelectedRows.count? nil:indexPath;
}

@end
