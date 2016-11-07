//
//  FSShareView.h
//  WTShare
//
//  Created by FudonFuchina on 16/9/4.
//  Copyright © 2016年 wutong. All rights reserved.
//

/*
 1.配置info中的LSApplicationQueriesSchemes 数组
 2.配置TARGET-info-URL Types
 3.在Application.m文件中添加一些方法
 
 */

#import <UIKit/UIKit.h>
#import "FSShareManager.h"
#import "FSShareEntity.h"

@interface FSShareView : UIView

- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)callController;

@end
