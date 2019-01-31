//
//  ViewController.m
//  VNNetWorking
//
//  Created by vine on 2019/1/25.
//  Copyright © 2019 vine. All rights reserved.
//

#import "ViewController.h"
#import "VNAPIDataFunc.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - enent responds

- (IBAction)requestClick:(UIButton *)sender {
    [self getJsonDataWithPage:1];
}
#pragma mark - private methods
- (void)getJsonDataWithPage:(NSInteger)pageIndex {
    [VNAPIManager getNewsAppsWithPage:pageIndex handler:^(id obj, NSError *error) {
        NSDictionary *aDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"json:%@",aDict);
    }];
}

@end
