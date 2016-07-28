//
//  HYHttpCilent.m
//  zhhx
//
//  Created by luculent on 16/5/17.
//  Copyright © 2016年 luculent. All rights reserved.
//

#import "HYHttpCilent.h"

@interface HYHttpCilent ()

@property (strong, nonatomic, readwrite) NSMutableArray *operationQueue;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation HYHttpCilent

+ (instancetype)shareManager {
    
    static HYHttpCilent *defaultClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultClient = [[HYHttpCilent alloc] init];
    });
    
    return defaultClient;
}

#pragma mark - Setter && Getter

- (NSString *)httpMethod {
    if (!_httpMethod.length) {
        _httpMethod = @"post";
    }
    
    return _httpMethod;
}

#pragma mark - Private

- (NSMutableArray *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [NSMutableArray array];
    }
    
    return _operationQueue;
}

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSMutableSet *set = [_manager.responseSerializer.acceptableContentTypes mutableCopy] ;
//        [set addObject:@"application/xml; charset=UTF-8"];
        _manager.responseSerializer.acceptableContentTypes= set;
    }
    
    return _manager;
}

#pragma mark - Message

+ (NSString *)absoluteUrlStringForPostParams:(NSDictionary *)params {
    __block NSString *urlStr = @"";
    
    [[params allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        urlStr = [urlStr stringByAppendingFormat:@"%@%@=%@",idx==0? @"":@"&", obj, params[obj]];
    }];
    return urlStr;
}

+ (NSDictionary *)paramsForSafeInterfaceFromParams:(NSDictionary *)params {
    
    return @{};
//    //TODO: 针对安全性添加的代码
//    
//    APP_CURRENT_USER
//    
//    NSString *susrnam = user.userId;
//    long long int time = (long long int)[[NSDate date] timeIntervalSince1970]*1000;
//    NSString *timestamp = @(time).stringValue;
//    NSString *appkey = Liems_APPKEY_ID;
//    NSString *secretkey = Liems_SECRETKEY_ID;
//    NSString *password = [[user.userId stringByAppendingString:user.pword] hy_md5String];
//    NSString *signStr = [secretkey stringByAppendingFormat:@"%@%@%@", susrnam, password, timestamp];
//    signStr = [signStr hy_md5String];
//    
//    
//    NSDictionary *restDic = @{@"susrnam": susrnam,
//                              @"timestamp": timestamp,
//                              @"appkey": appkey,
//                              @"sign": signStr};
//    
//    NSMutableDictionary *tempDic = [params mutableCopy];
//    [tempDic setValuesForKeysWithDictionary:restDic];
//    
//    return [tempDic copy];
}

- (NSURLRequest *)textRequestWithHttpMethod:(NSString *)httpMethod urlString:(NSString *)urlString httpBody:(id)httpBody {
    __block NSString *urlStr = urlString;
    
    //    NSString *idSuffix = nil;
    
    //TODO: 根据每个项目是否需要添加信息
    //    if ([urlString rangeOfString:@"?"].length) {
    //        idSuffix = [@"&" stringByAppendingFormat:@"userID=%@&OrgID=%@", user.USER_ID, user.STORE_ID];
    //    } else {
    //        idSuffix = [@"?" stringByAppendingFormat:@"userID=%@&OrgID=%@", user.USER_ID, user.STORE_ID];
    //    }
    //    urlStr = [urlStr stringByAppendingString:idSuffix];
    
    __block NSString *bodyStr = @"";
    NSString *method = httpMethod.length? httpMethod:self.httpMethod;
    method = [method uppercaseString];
    
    if (httpBody) {
        NSAssert([httpBody isKindOfClass:[NSDictionary class]], @"传入参数类型不正确");
    }
    
    httpBody = [HYHttpCilent paramsForSafeInterfaceFromParams:httpBody];
    
    if ([method isEqualToString:@"GET"]) {
        [[httpBody allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            urlStr = [urlStr stringByAppendingFormat:@"%@%@=%@",idx==0? @"?":@"&", obj, httpBody[obj]];
        }];
    } else if ([method isEqualToString:@"POST"]) {
        [[httpBody allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            bodyStr = [bodyStr stringByAppendingFormat:@"%@%@=%@",idx==0? @"":@"&", obj, httpBody[obj]];
        }];
    } else {
        NSAssert(0, @"设置的method不正确，仅支持GET/POST");
    }
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = nil;
    
    if (self.baseUrlStr.length) {
        url = [NSURL URLWithString:[self.baseUrlStr stringByAppendingString:urlStr]];
    } else {
        url = [NSURL URLWithString:urlStr];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = method;

    if ([method isEqualToString:@"POST"]) {
        request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    
//    if ([httpBody isKindOfClass:[NSDictionary class]]) {
//        [httpBody enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            [request setValue:obj forHTTPHeaderField:key];
//        }];
//    } else {
//        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        request.HTTPBody = httpBody;
//    }

    //设置超时时间
    request.timeoutInterval = 30;
    return request;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [self HTTPRequestOperationWithRequest:request success:success failure:failure willFinishBlock:nil didFinishBlock:nil];
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure willFinishBlock:(void (^)(BOOL isSuccess))willFinishBlock didFinishBlock:(void (^)(BOOL isSuccess))didFinishBlock {
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (willFinishBlock) {
            willFinishBlock(YES);
        }
        
        success(operation, responseObject);

        if (didFinishBlock) {
            didFinishBlock(YES);
        }

    }  failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        if (willFinishBlock) {
            willFinishBlock(NO);
        }

        NSError *handleError = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey:@"网络异常，请重试"}];
        failure(operation, handleError);
        
        if (didFinishBlock) {
            didFinishBlock(NO);
        }
    }];;
    [self.manager.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationCustomFinishBlockWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure willFinishBlock:(void (^)(BOOL))willFinishBlock didFinishBlock:(void (^)(BOOL))didFinishBlock {
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:success failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        if (willFinishBlock) {
            willFinishBlock(NO);
        }
        
        NSError *handleError = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey:@"网络异常，请重试"}];
        failure(operation, handleError);
        
        if (didFinishBlock) {
            didFinishBlock(NO);
        }
    }];;
    [self.manager.operationQueue addOperation:operation];
    
    return operation;
}

+ (NSError *)errorForUnmatchResponse {
    return [NSError errorWithDomain:@"UnmatchResponse" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"无数据"}];
}

- (void)setBaseUrlStr:(NSString *)baseUrlStr {
    
    if ([baseUrlStr hasPrefix:@"http"]) {
        _baseUrlStr = baseUrlStr;
    } else {
        _baseUrlStr = [@"http://" stringByAppendingString:baseUrlStr];
    }
}

- (void)cancleOperation:(AFHTTPRequestOperation *)operation {
    
    [operation cancel];
    
    if ([self.operationQueue containsObject:operation]) {
        [self.operationQueue removeObject:operation];
    }
}

- (void)cancleAllOperations {
    for (AFHTTPRequestOperation *operation in self.operationQueue) {
        [operation cancel];
        [self.operationQueue removeObject:operation];
    }
}

@end
