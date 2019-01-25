//
//  VNAPIManager+home.h
//  VNNetWorking
//
//  Created by vine on 2019/1/25.
//  Copyright © 2019 vine. All rights reserved.
//

#import "VNAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface VNAPIManager (home)
/**
 *  获取应用信息
 *  
 *  @param pageNum 第几页
 *  @param handler 返回数据的回调
 */
+(void)getNewsAppsWithPage:(NSInteger)pageNum handler:(GetDataHandler)handler;
@end

NS_ASSUME_NONNULL_END
