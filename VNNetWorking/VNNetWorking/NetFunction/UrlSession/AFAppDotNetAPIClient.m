//
//  AFAppDotNetAPIClient.m
//  VNNetWorking
//
//  Created by vine on 2019/1/30.
//  Copyright © 2019 vine. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:MY_DOMAIN_NAME_A]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}
- (NSURLSessionDataTask *)accessServerWithURLStr:(NSString *)urlStr andHandler:(NetHandler)handler  {
    NSURLSessionDataTask *dataTask =
    [self GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) {
            handler(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (handler) {
            handler(nil, error);
        }
    }];
    return dataTask;
}
- (NSURLSessionDataTask *)postAccessServerWithURLStr:(NSString *)urlStr andBody:(NSString *)Body andHandler:(NetHandler)handler {
    NSURLSessionDataTask *dataTask =
    [self POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) {
            handler(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (handler) {
            handler(nil, error);
        }
    }];
    return dataTask;
}
@end
