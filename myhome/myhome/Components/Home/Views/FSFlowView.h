//
//  FSFlowView.h
//  FSFlowView
//
//  Created by fudon on 2016/12/3.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSFlowView : UIView

@property (nonatomic,copy) void (^btnClick)(UIButton *bButton);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)titleColor btnBackColor:(UIColor *)backColor lineColor:(UIColor *)lineColor;

@end
