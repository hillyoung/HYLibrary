//
//  HYFormCellDataSource.m
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import "HYFormDataSource.h"

@implementation HYFormRowDataSource

- (BOOL)isValueValid {
    if ([self.value isKindOfClass:NSString.class]) {
        return [self.value length];
    } else if ([self.value isKindOfClass:NSArray.class]) {
        return [self.value count];
    }
    return self.value;
}

+ (HYFormRowDataSource *)findDataSourceWithField:(NSString *)field inDataSources:(NSArray<HYFormRowDataSource *> *)dataSources {
    __block HYFormRowDataSource *datasource = nil;
    [dataSources enumerateObjectsUsingBlock:^(HYFormRowDataSource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.field isEqualToString:field]) {
            datasource = obj;
            *stop = YES;
        }
    }];
    return datasource;
}

+ (HYFormRowDataSource *)checkDataSourceRequiredInDataSources:(NSArray<HYFormRowDataSource *> *)dataSources {
    __block HYFormRowDataSource *datasource = nil;
    [dataSources enumerateObjectsUsingBlock:^(HYFormRowDataSource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.required && ![obj isValueValid]) {
            datasource = obj;
            *stop = YES;
        }
    }];
    return datasource;
}

@end


@implementation HYFormSectionDataSource

- (instancetype)init {
    if (self = [super init]) {
        _height = UITableViewAutomaticDimension;
    }
    return self;
}

- (HYFormSectionDataSource * _Nonnull (^)(HYFormRowDataSource * _Nonnull))addRow {
    HYFormSectionDataSource *(^result)(HYFormRowDataSource *row) = ^(HYFormRowDataSource *row) {
        [self.rows addObject:row];
        return self;
    };
    return result;
}

+ (HYFormRowDataSource *)findRowDataSourceAtIndexPath:(NSIndexPath *)indexPath inSectionDataSources:(NSArray<HYFormSectionDataSource *> *)dataSources {
    
    HYFormSectionDataSource *sectionM;
    if (indexPath.section < dataSources.count) {
        sectionM = [dataSources objectAtIndex:indexPath.section];
    }
    if (indexPath.row < sectionM.rows.count) {
        return [sectionM.rows objectAtIndex:indexPath.row];
    }
    return nil;
}

- (NSMutableArray<HYFormRowDataSource *> *)rows {
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

@end
