//
//  VNAPIManager+home.m
//  VNNetWorking
//
//  Created by vine on 2019/1/25.
//  Copyright © 2019 vine. All rights reserved.
//

#import "VNAPIManager+home.h"

@implementation VNAPIManager (home)
+(void)getNewsAppsWithPage:(NSInteger)pageNum handler:(GetDataHandler)handler{
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@?",MY_DOMAIN_NAME_A,MY_Main_PRO];
    
    [URLStr appendFormat:@"%@",@"id=SYLB10,SYDT10,SYRECOMMEND"];
    [URLStr appendFormat:@"&page=%ld",pageNum];
    [URLStr appendFormat:@"&gv=4.5.1&av=4.5.1&uid=865665020505370&deviceid=865665020505370&proid=ifengnews"];
    
    DebugLog(@"%@",[NSString stringWithFormat:@"%@",URLStr]);
    
    [[VNUrlSession defaultSession] accessServerWithURLStr:URLStr andHandler:^(NSData *data, NSError *error) {
        handler(data, error);
    }];
}
@end
