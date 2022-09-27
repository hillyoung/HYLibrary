//
//  HYFormViewDelegate.h
//  HYLibrary
//
//  Created by hillyoung on 2022/9/27.
//

#import <UIKit/UIKit.h>
#import "HYFormDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYTableViewFormDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray<HYFormSectionDataSource *> *groups;   /**< 数据源 */
@end

NS_ASSUME_NONNULL_END
