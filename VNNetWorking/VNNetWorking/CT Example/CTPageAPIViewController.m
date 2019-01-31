//
//  CTPageAPIViewController.m
//  VNNetWorking
//
//  Created by vine on 2019/1/31.
//  Copyright © 2019 vine. All rights reserved.
//

#import "CTPageAPIViewController.h"
#import <CTNetworking/CTNetworking.h>
// 这里是接口
#import "CTAMapAssistantInputTipsAPIManager.h"
#import "ResultView.h"

@interface CTPageAPIViewController ()<
// 这里是内容回调
CTAPIManagerCallBackDelegate,
// 这里是参数
CTAPIManagerParamSource
>
@property (nonatomic, strong) CTAPIBaseManager *apiManager;
@end

@implementation CTPageAPIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.apiManager = [[CTAMapAssistantInputTipsAPIManager alloc]init];
    self.apiManager.paramSource = self;
    self.apiManager.delegate = self;
}
#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager
{
    if ([manager isKindOfClass:[CTAMapAssistantInputTipsAPIManager class]]) {
        return [self paramsForAssistantInput];
    }
    return nil;
}
#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager
{
    [ResultView configWithString:manager.response.logString inView:self.view];
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
{
    [ResultView configWithString:manager.response.logString inView:self.view];
}
- (IBAction)btnClick:(UIButton *)sender {
    [self.apiManager loadData];
    [ResultView showInView:self.view];
}

#pragma mark - getters and setter
- (NSDictionary *)paramsForAssistantInput
{
    return @{
             kCTAMapAssistantInputTipsAPIManagerRequiredParamKeyKeywords:@"屈臣氏",
             kCTAMapAssistantInputTipsAPIManagerOptionalParamKeyNearLocation:@{
                     @"lat":@(31.23),
                     @"lng":@(121.48)
                     },
             kCTAMapAssistantInputTipsAPIManagerOptionalParamKeyCityCode:@"021",
             kCTAMapAssistantInputTipsAPIManagerOptionalParamKeyIsLimitToCity:@(YES)
             };
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
