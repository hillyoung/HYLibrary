//
//  HYActionSheet.m
//  MDPMS
//
//  Created by luculent on 16/6/16.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYActionSheet.h"
#import "JGActionSheet.h"

/**
 基于cocoapods管理的JGActionSheet.h
*/
@implementation HYActionSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)showWithTitle:(NSString *)title message:(NSString *)message {
    
    NSUInteger optionCount = 0;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfOptionsActionSheet:)]) {
        optionCount = [self.dataSource numberOfOptionsActionSheet:self];
    }
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:optionCount];
    
    
    for (int i = 0; i < optionCount; i ++) {
        
        if ([self.dataSource respondsToSelector:@selector(actionSheet:titleForOptionAtIndex:)]) {
            NSString *title = @"";
            title = [self.dataSource actionSheet:self titleForOptionAtIndex:i];
            [titles addObject:title];
        }
    }
    
    JGActionSheetSection *optionsSection = [JGActionSheetSection sectionWithTitle:title message:message buttonTitles:titles buttonStyle:JGActionSheetButtonStyleDefault];

    JGActionSheetSection *cancleSecton = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:@[optionsSection, cancleSecton]];
    [sheet setButtonPressedBlock:^(JGActionSheet *actionSheet, NSIndexPath *indexPath) {
        [actionSheet dismissAnimated:YES];
        
        if (indexPath.section == 1) {
            return ;
        }
        
        if ([self.delegate respondsToSelector:@selector(actionSheet:didSelectedAtIndex:)]) {
            [self.delegate actionSheet:self didSelectedAtIndex:indexPath.row];
        }
        
    }];
    
    [sheet showInView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
}

@end
