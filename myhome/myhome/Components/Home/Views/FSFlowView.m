//
//  FSFlowView.m
//  FSFlowView
//
//  Created by fudon on 2016/12/3.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSFlowView.h"

@implementation FSFlowView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)titleColor btnBackColor:(UIColor *)backColor lineColor:(UIColor *)lineColor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self flowDesignViewsWithTitles:titles titleColor:titleColor btnBackColor:backColor lineColor:lineColor];
    }
    return self;
}

- (void)flowDesignViewsWithTitles:(NSArray<NSString *> *)titles titleColor:(UIColor *)titleColor btnBackColor:(UIColor *)backColor lineColor:(UIColor *)lineColor
{
    CGFloat width = (self.bounds.size.width - 2 * 30 - 2 * 50) / 3;
    for (int x = 0; x < titles.count; x ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(30 + (width + 50) * (x % 3), 20 + (width + 40) * (x / 3), width, width);
        button.backgroundColor = backColor;
        [button setTitle:titles[x] forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        button.layer.cornerRadius = button.frame.size.width / 2;
        [self addSubview:button];
        
        CGRect frame = CGRectZero;
        if (x == 2) {
            frame = CGRectMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height, .5, 40);
        }else if (x != 5){
            frame = CGRectMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y + width / 2 - 0.25, 50, 0.5);
        }
        UIView *line = [[UIView alloc] initWithFrame:frame];
        line.backgroundColor = lineColor;
        [self addSubview:line];
    }
    CGFloat height = 20 + width + 40 + width + 20;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
