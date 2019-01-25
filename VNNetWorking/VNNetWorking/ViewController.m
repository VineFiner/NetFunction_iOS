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
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.btn.frame = CGRectMake(30, 100, self.view.frame.size.width-60, 50);
}
#pragma mark - enent responds
- (void)btnClick:(UIButton *)btn {
    [self getJsonDataWithPage:1];
}
#pragma mark - private methods
- (void)getJsonDataWithPage:(NSInteger)pageIndex {
    [VNAPIManager getNewsAppsWithPage:pageIndex handler:^(id obj, NSError *error) {
        NSDictionary *aDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"json:%@",aDict);
    }];
}
#pragma mark - getters and setter
- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [[UIButton alloc]init];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = [UIColor orangeColor];
    }
    return _btn;
}
@end
