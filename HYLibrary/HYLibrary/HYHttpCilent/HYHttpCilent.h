//
//  HYHttpCilent.h
//  zhhx
//
//  Created by luculent on 16/5/17.
//  Copyright © 2016年 luculent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^willFinishBlock)(BOOL isSuccess);
typedef void(^didFinishBlock)(BOOL isSuccess);

@interface HYHttpCilent : NSObject

/**
 *  基本地址
 */
@property (copy, nonatomic) NSString *baseUrlStr ;

/**
 *  默认为POST
 */
@property (copy, nonatomic) NSString *httpMethod ;

/**
 *  最大并发请求数
 */
@property (nonatomic) NSUInteger maxRequestCount ;

/**
 *  获取单例管理者
 */
+ (instancetype)shareManager;

/**
 *  返回关于，服务器数据格式不正确的error
 *
 */
+ (NSError *)errorForUnmatchResponse ;

- (void)cancleOperation:(NSURLSessionDataTask *)task;

- (void)cancleAllOperations;


/**
 *  传入参数dictionary，返回拼接后的完整url
 *
 *  @param params 参数dictionary
 *
 *  @return 返回拼接后的完整url
 */
+ (NSString *)absoluteUrlStringForPostParams:(NSDictionary *)params ;


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
- (NSURLSessionDataTask *)taskWithRequest:(NSURLRequest *)request success:(void (^)(NSURLResponse *response, id responseObject))success failure:(void (^)(NSURLResponse *response, NSError *error))failure ;


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
- (NSURLSessionDataTask *)taskWithRequest:(NSURLRequest *)request success:(void (^)(NSURLResponse *response, id responseObject))success failure:(void (^)(NSURLResponse *response, NSError *error))failure willFinishBlock:(willFinishBlock)willFinishBlock didFinishBlock:(didFinishBlock)didFinishBlock ;

@end
