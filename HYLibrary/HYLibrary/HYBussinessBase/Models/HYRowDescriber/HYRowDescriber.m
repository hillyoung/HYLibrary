//
//  HYRowDescriber.m
//  HYLibrary
//
//  Created by yanghaha on 17/3/27.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import "HYRowDescriber.h"

@implementation HYRowDescriber

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title textKey:(NSString *)textKey text:(NSString *)text {
    if (self = [super init]) {
        _identifier = identifier;
        _title = title;
        _textKey = textKey;
        _text = text;
    }
    return self;
}

- (void)updateRowDescriberWithDict:(NSDictionary *)dict {
    self.text = dict[self.textKey];
}

- (NSDictionary *)netParams {
    return [NSDictionary dictionaryWithObject:self.text forKey:self.textKey];
}

@end


@implementation HYFieldRowDescriber

@end

@implementation HYMetadataRowDescriber

- (void)updateRowDescriberWithDict:(NSDictionary *)dict {
    [super updateRowDescriberWithDict:dict];
    self.value = dict[self.valueKey];
}

- (NSDictionary *)netParams {
    return [NSDictionary dictionaryWithObject:self.value forKey:self.valueKey];
}

@end

