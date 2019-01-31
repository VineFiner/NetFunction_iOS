// Post.m
//
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Post.h"
#import "AFAppDotNetAPIClient.h"

@implementation Post

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    //
    self.title = [attributes valueForKeyPath:@"title"];
    self.thumbnail = [attributes valueForKeyPath:@"thumbnail"];
    self.source = [attributes valueForKeyPath:@"source"];
    return self;
}

#pragma mark -

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@?",MY_DOMAIN_NAME_A,MY_Main_PRO];
    
    [URLStr appendFormat:@"%@",@"id=SYLB10,SYDT10,SYRECOMMEND"];
    [URLStr appendFormat:@"&page=1"];
    [URLStr appendFormat:@"&gv=4.5.1&av=4.5.1&uid=865665020505370&deviceid=865665020505370&proid=ifengnews"];
    
    NSURLSessionDataTask *dataTask =
    [[AFAppDotNetAPIClient sharedClient] accessServerWithURLStr:URLStr andHandler:^(NSData *data, NSError *error) {
        if (data) {
            NSMutableArray *mutablePosts = [NSMutableArray new];
            if ([data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *aDict in (NSArray *)data) {
                    NSString *type = aDict[@"type"];
                    if ([type isEqualToString:@"list"]) {
                        NSArray *items = [aDict valueForKeyPath:@"item"];
                        for (NSDictionary *attributes in items) {
                            Post *post = [[Post alloc] initWithAttributes:attributes];
                            [mutablePosts addObject:post];
                        }
                    }
                }
            }
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
        }else {
            if (block) {
                block([NSArray array], error);
            }
        }
    }];
    return dataTask;
}

@end
