//
//  FSTouchView.h
//  WTShare
//
//  Created by FudonFuchina on 16/9/4.
//  Copyright © 2016年 wutong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSTouchView : UIView

@property (nonatomic,copy) void (^tapBlock)(void);

@end
