//
//  VNUrlSession.h
//  VNNetWorking
//
//  Created by vine on 2019/1/25.
//  Copyright © 2019 vine. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  访问网络的block回调
 *
 *  @param data  拿到的网络数据
 *  @param error 错误标记
 */
typedef void(^NetHandler)(NSData * data, NSError * error);

/**网络数据加载的类，这个类，只负责网络数据的加载，它使一个单例类*/

NS_ASSUME_NONNULL_BEGIN

@interface VNUrlSession : NSObject
/**
 *  单例接口
 *
 *  @return 单例对象
 */
+(VNUrlSession *)defaultSession;
/**
 *  通过url字符创访问服务器，获取结果
 *
 *  @param urlStr  url字符串
 *  @param handler 结果的回调
 */
-(void)accessServerWithURLStr:(NSString *)urlStr andHandler:(NetHandler)handler;
/**
 *  通过Post请求访问服务器
 *
 *  @param urlStr  url字符串
 *  @param Body    请求体
 *  @param handler 结果的回调
 */
-(void)postAccessServerWithURLStr:(NSString *)urlStr andBody:(NSString *)Body andHandler:(NetHandler)handler;
@end

NS_ASSUME_NONNULL_END
