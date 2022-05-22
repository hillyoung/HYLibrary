//
//  SDRouterProducer.m
//  SimpleTool
//
//  Created by 2 on 2020/9/15.
//  Copyright © 2020 hillyoung. All rights reserved.
//

#import "HYRouterProducer.h"
#import "YYModel.h"


@implementation HYURLType

- (NSArray<NSURL *> *)availableURLs {
    NSMutableArray *URLs = [NSMutableArray arrayWithCapacity:self.CFBundleURLSchemes.count];
    [self.CFBundleURLSchemes enumerateObjectsUsingBlock:^(NSString *scheme, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlStr = [NSString stringWithFormat:@"%@://%@", scheme, self.CFBundleURLName];
        [URLs addObject:[NSURL URLWithString:urlStr]];
    }];
    return URLs;
}

- (NSURL *)defaultURL {
    return [self availableURLs].firstObject;
}

@end

@implementation HYRouterProducer

+ (instancetype)shareProducer {
    static HYRouterProducer *producer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HYURLType *urlType = [self urlTypeFromInfoPlist].firstObject;
        producer = [HYRouterProducer new];
        producer.baseURL = urlType.availableURLs.firstObject;
    });
    
    return producer;
}

- (NSURL *)absoluteURLForPath:(NSString *)path {
    return [NSURL URLWithString:path relativeToURL:self.baseURL];
}

+ (NSArray *)urlTypeFromInfoPlist {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSArray *urlTypes = [NSArray yy_modelArrayWithClass:HYURLType.class json:[info objectForKey:@"CFBundleURLTypes"]];
    NSAssert(urlTypes.count, @"请配置Scheme");
    return urlTypes;
}

+ (NSArray<HYRouterProducer *> *)getProducersFromInfoPlist {
    
    NSArray *urlTypes = [self urlTypeFromInfoPlist];
    
    NSMutableArray<HYRouterProducer *> *producers = [NSMutableArray arrayWithCapacity:urlTypes.count];
    for (HYURLType *urlType in urlTypes) {
        [[urlType availableURLs] enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL * _Nonnull stop) {
            HYRouterProducer *producer = [HYRouterProducer new];
            producer.baseURL = url;
            [producers addObject:producer];
        }];
    }
    return producers;
}

@end
