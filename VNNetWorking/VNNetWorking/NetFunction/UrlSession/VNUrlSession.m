//
//  VNUrlSession.m
//  VNNetWorking
//
//  Created by vine on 2019/1/25.
//  Copyright © 2019 vine. All rights reserved.
//

#import "VNUrlSession.h"

@interface VNUrlSession ()<NSURLSessionDelegate>
{
    //用来访问网络的会话请求
    NSURLSession * _session;
}

@end
@implementation VNUrlSession
//初始化
-(instancetype)init{
    if (self = [super init]) {
        //实例化session
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        //session对象
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    return self;
}

//单例对象
+(VNUrlSession *)defaultSession{
    static VNUrlSession * session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[VNUrlSession alloc]init];
    });
    return session;
}
//访问网络的方法
#pragma mark - 接口方法
//访问服务器
-(void)accessServerWithURLStr:(NSString *)urlStr andHandler:(NetHandler)handler{

    //url字符串utf8编码
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //创建request
    NSURL * URL = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    //访问服务器
    NSURLSessionDataTask * dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //这里拿到服务器返回结果，在这里返回
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //这里是主线程
            if (handler) {
                handler(data,error);
            }
        });
    }];
    //开始下载
    [dataTask resume];
    
}
//post请求
-(void)postAccessServerWithURLStr:(NSString *)urlStr andBody:(NSString *)Body andHandler:(NetHandler)handler{
    //url字符串
    NSURL * URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    //设置请求方式
    request.HTTPMethod = @"POST";
    // 设置请求体
    NSData * body = [Body dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = body;
    /**
     *  异步加载数据
     */
    NSURLSessionDataTask * dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //返回主线程进行下载数据调用
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //这里是主线程
            if (handler) {
                handler(data,error);
            }
        });
    }];
    //调用resume方法开始执行下载
    [dataTask resume];
    
}
@end
