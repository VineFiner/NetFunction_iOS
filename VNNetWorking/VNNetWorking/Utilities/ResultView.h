//
//  ResultView.h
//  VNNetWorking
//
//  Created by vine on 2019/1/31.
//  Copyright © 2019 vine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultView : UIView

+ (void)showInView:(UIView *)view;
+ (void)configWithString:(NSString *)resultString inView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
