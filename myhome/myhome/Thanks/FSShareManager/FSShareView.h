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

typedef enum : NSInteger {
    FSShareTypeQQ = 0,      // QQ好友
    FSShareTypeQQZone,      // QQ空间
    FSShareTypeWechat,      // 微信好友
    FSShareTypeWXFriends,   //微信朋友圈
    FSShareTypeWXStore,     // 微信收藏
    FSShareTypeWeibo,       // 微博
    FSShareTypeMessage,     // 短信
    FSShareTypeCopy         // 电子邮件
} FSShareType;

@interface FSShareView : UIView

- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)callController;

@property (nonatomic,copy) void (^block)(FSShareView *bShareView,NSInteger bType);

@end
