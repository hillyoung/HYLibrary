//
//  HYCollectionVC.m
//  HYLibrary_Example
//
//  Created by hillyoung on 2022/9/27.
//  Copyright © 2022 hillyoung. All rights reserved.
//

#import "HYCollectionVC.h"
#import <HYLibrary/HYLibrary.h>
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>


@interface HYCollectionCell : UICollectionViewCell <HYFormCellConfigProtocol>

@end

@implementation HYCollectionCell

- (void)update:(HYFormRowDataSource *)datasource {
    self.contentView.backgroundColor = [UIColor randomColor];
    self.contentView.layer.borderWidth = datasource.selected ? 2.0:0;
    self.contentView.layer.borderColor = [UIColor redColor].CGColor;
}

@end



@interface HYCollectionVC ()
@property (nonatomic, strong) HYCollectionViewFormDelegate *viewDelegate;
@property (nonatomic, strong) UICollectionView *colletionView;
@end

@implementation HYCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewDelegate = [HYCollectionViewFormDelegate new];
    self.viewDelegate.rows = [NSArray yy_modelArrayWithClass:HYFormRowDataSource.class json:@[
        @{
            @"identifier":@"HYCollectionCell",
            @"title":@"默认轨迹",
            @"target": self,
            @"value":@"当前航次",
            @"selector":@"selectePositionAtIndexPath:"
        },@{
            @"identifier":@"HYCollectionCell",
            @"title":@"默认轨迹",
            @"target": self,
            @"value":@"当前航次",
            @"selector":@"selectePositionAtIndexPath:"
        }
    ]];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 300);
    layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
    self.colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.colletionView.dataSource = self.viewDelegate;
    self.colletionView.delegate = self.viewDelegate;
    [self.colletionView registerClass:HYCollectionCell.class forCellWithReuseIdentifier:@"HYCollectionCell"];
    [self.view addSubview:self.colletionView];
    [self.colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];    
}

- (void)selectePositionAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewDelegate.rows enumerateObjectsUsingBlock:^(HYFormRowDataSource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    
    HYFormRowDataSource *rowM = [self.viewDelegate.rows objectAtIndex:indexPath.row];
    rowM.selected = YES;
    [self.colletionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

@end
