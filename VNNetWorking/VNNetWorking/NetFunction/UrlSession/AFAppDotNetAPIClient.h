//
//  AFAppDotNetAPIClient.h
//  VNNetWorking
//
//  Created by vine on 2019/1/30.
//  Copyright © 2019 vine. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "VNNetHeader.h"
/**
 *  访问网络的block回调
 *
 *  @param data  拿到的网络数据
 *  @param error 错误标记
 */
typedef void(^NetHandler)(NSData * data, NSError * error);
NS_ASSUME_NONNULL_BEGIN

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

/**
 *  通过url字符创访问服务器，获取结果
 *
 *  @param urlStr  url字符串
 *  @param handler 结果的回调
 */
-(NSURLSessionDataTask *)accessServerWithURLStr:(NSString *)urlStr andHandler:(NetHandler)handler;
/**
 *  通过Post请求访问服务器
 *
 *  @param urlStr  url字符串
 *  @param Body    请求体
 *  @param handler 结果的回调
 */
-(NSURLSessionDataTask *)postAccessServerWithURLStr:(NSString *)urlStr andBody:(NSString *)Body andHandler:(NetHandler)handler;
@end

NS_ASSUME_NONNULL_END
