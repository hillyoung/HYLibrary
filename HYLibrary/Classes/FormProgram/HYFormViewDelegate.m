//
//  HYFormViewDelegate.m
//  HYLibrary
//
//  Created by hillyoung on 2022/9/27.
//

#import "HYFormViewDelegate.h"
#import "UITableView+HYFormProgram.h"


@implementation HYTableViewFormDelegate

#pragma mark -- UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HYFormSectionDataSource *sectionM = [self.groups objectAtIndex:section];
    return sectionM.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYFormSectionDataSource *sectionM = [self.groups objectAtIndex:indexPath.section];
    HYFormRowDataSource *rowM = [sectionM.rows objectAtIndex:indexPath.row];
    UITableViewCell<HYFormCellConfigProtocol> *cell = [tableView dequeueReusableCellWithDataSource:rowM];
    [cell update:rowM];
    return cell;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYFormSectionDataSource *sectionM = [self.groups objectAtIndex:indexPath.section];
    HYFormRowDataSource *rowM = [sectionM.rows objectAtIndex:indexPath.row];
    return rowM.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HYFormSectionDataSource *sectionM = [self.groups objectAtIndex:section];
    return sectionM.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HYFormSectionDataSource *sectionM = [self.groups objectAtIndex:section];
    UITableViewHeaderFooterView<HYFormSectionConfigProtocol> *view = [tableView dequeueReusableHeaderFooterViewWithDataSource:sectionM];
    [view update:sectionM];
    if(!view) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYFormSectionDataSource *sectionM = [self.groups objectAtIndex:indexPath.section];
    HYFormRowDataSource *rowM = [sectionM.rows objectAtIndex:indexPath.row];
    SEL selector = rowM.selector;
    if ([rowM.target respondsToSelector:selector]) {   // 判断是否能响应对应的点击事件
        [rowM.target performSelector:selector withObject:indexPath afterDelay:0.0];
    }
}

@end
