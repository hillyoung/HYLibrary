//
//  HYHttpCilent.h
//  zhhx
//
//  Created by luculent on 16/5/17.
//  Copyright © 2016年 luculent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^success)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^failure)(AFHTTPRequestOperation *operation, NSError *error);
typedef void(^willFinishBlock)(BOOL isSuccess);
typedef void(^didFinishBlock)(BOOL isSuccess);
/**
 *  基于AFNetworking2.0封装
 */
@interface HYHttpCilent : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *operationQueue;

@property (strong, nonatomic, readonly) AFHTTPRequestOperationManager *manager;

@property (copy, nonatomic) NSString *baseUrlStr ;
@property (copy, nonatomic) NSString *httpMethod ;

+ (instancetype)shareManager;


/**
 *  返回关于，服务器数据格式不正确的error
 *
 */
+ (NSError *)errorForUnmatchResponse ;

- (void)cancleOperation:(AFHTTPRequestOperation *)operation;

- (void)cancleAllOperations;


/**
 *  传入参数dictionary，返回拼接后的完整url
 *
 *  @param params 参数dictionary
 *
 *  @return 返回拼接后的完整url
 */
+ (NSString *)absoluteUrlStringForPostParams:(NSDictionary *)params ;

/**
 *  返回，给制定参数加上，安全接口所需的参数
 */
+ (NSDictionary *)paramsForSafeInterfaceFromParams:(NSDictionary *)params ;

- (NSURLRequest *)textRequestWithHttpMethod:(NSString *)httpMethod urlString:(NSString *)urlString httpBody:(id)httpBody ;

/**
 *  开始发起一个http请求
 *
 *  @param request 将要发起的请求
 *  @param success 成功的回调
 *  @param failure 失败的回调
 *
 *  @return http请求任务
 */
- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure ;


/**
 *  开始发起一个http请求
 *
 *  @param request 将要发起的请求
 *  @param success 成功的回调
 *  @param failure 失败的回调
 *  @param willFinishBlock 请求将要完成的时候的回调
 *  @param didFinishBlock 请求完成后的时候的回调
 *
 *  @return http请求任务
 */
- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure willFinishBlock:(willFinishBlock)willFinishBlock didFinishBlock:(didFinishBlock)didFinishBlock ;

/**
 *  开始发起一个http请求, 并将finish的执行延迟到指定接口方法中
 *
 *  @param request 将要发起的请求
 *  @param success 成功的回调
 *  @param failure 失败的回调
 *  @param willFinishBlock 请求将要完成的时候的回调
 *  @param didFinishBlock 请求完成后的时候的回调
 *
 *  @return http请求任务
 */
- (AFHTTPRequestOperation *)HTTPRequestOperationCustomFinishBlockWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure willFinishBlock:(willFinishBlock)willFinishBlock didFinishBlock:(didFinishBlock)didFinishBlock ;



@end
