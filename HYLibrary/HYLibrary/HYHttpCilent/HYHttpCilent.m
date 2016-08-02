//
//  HYHttpCilent.m
//  zhhx
//
//  Created by luculent on 16/5/17.
//  Copyright © 2016年 luculent. All rights reserved.
//

#import "HYHttpCilent.h"
#import "HYHttpCilent+SafeParams.h"

@interface HYHttpCilent () <NSURLSessionDelegate>

@property (strong, nonatomic) NSOperationQueue *operationQueue ;
@property (strong, nonatomic) NSURLSession *session ;

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

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 10;
    }
    return _operationQueue;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:self.operationQueue];
    }
    return _session;
}

- (void)setMaxRequestCount:(NSUInteger)maxRequestCount {
    _maxRequestCount = maxRequestCount;
    
    self.operationQueue.maxConcurrentOperationCount = _maxRequestCount;
}

#pragma mark - Private

#pragma mark - Message

+ (NSString *)absoluteUrlStringForPostParams:(NSDictionary *)params {
    __block NSString *urlStr = @"";
    
    [[params allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        urlStr = [urlStr stringByAppendingFormat:@"%@%@=%@",idx==0? @"":@"&", obj, params[obj]];
    }];
    return urlStr;
}

- (NSURLRequest *)textRequestWithHttpMethod:(NSString *)httpMethod urlString:(NSString *)urlString httpBody:(id)httpBody {
    __block NSString *urlStr = urlString;
    
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
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
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
    
    //设置超时时间
    request.timeoutInterval = 30;
    return request;
}

- (NSURLSessionDataTask *)taskWithRequest:(NSURLRequest *)request success:(void (^)(NSURLResponse *response, id responseObject))success failure:(void (^)(NSURLResponse *response, NSError *error))failure {
    return [self taskWithRequest:request success:success failure:failure willFinishBlock:nil didFinishBlock:nil];
}

- (NSURLSessionDataTask *)taskWithRequest:(NSURLRequest *)request success:(void (^)(NSURLResponse *response, id responseObject))success failure:(void (^)(NSURLResponse *response, NSError *error))failure willFinishBlock:(void (^)(BOOL isSuccess))willFinishBlock didFinishBlock:(void (^)(BOOL isSuccess))didFinishBlock {
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //将要结束调用
            if (willFinishBlock) {
                willFinishBlock(YES);
            }
            
            if (!error) {
                
                NSError *serializaError = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializaError];
                
                if (serializaError) {
                    responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    success(response, responseObject);
                } else {
                    success(response, data);
                }
                
            } else {
                NSError *handleError = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey:@"网络异常，请重试"}];
                failure(response, handleError);
            }
            
            //已经结束
            if (didFinishBlock) {
                didFinishBlock(YES);
            }
        });
    }];
    
    [task resume];
    
    return task;
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

- (void)cancleOperation:(NSURLSessionDataTask *)task {
    
}

- (void)cancleAllOperations {
    
}

#pragma mark - NSURLSessionDataDelegate


@end
