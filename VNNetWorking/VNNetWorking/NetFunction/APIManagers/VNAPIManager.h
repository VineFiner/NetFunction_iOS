//
//  VNAPIManager.h
//  VNNetWorking
//
//  Created by vine on 2019/1/25.
//  Copyright © 2019 vine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VNNetHeader.h"
#import "VNUrlSession.h"

/**
 获取数据的block回调

 @param obj 拿到的数据
 @param error 错误标记
 */
typedef void(^GetDataHandler)(id obj,NSError * error);

NS_ASSUME_NONNULL_BEGIN

@interface VNAPIManager : NSObject
//可以继承或者扩展、来进行分模块
@end

NS_ASSUME_NONNULL_END
