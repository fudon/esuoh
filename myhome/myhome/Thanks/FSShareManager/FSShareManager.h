//
//  FSShareManager.h
//  WTShare
//
//  Created by FudonFuchina on 16/9/4.
//  Copyright © 2016年 wutong. All rights reserved.
//

// https://github.com/coderTong/WTShare

#import <Foundation/Foundation.h>

#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>

@class WTShareContentItem;

typedef NS_ENUM(NSInteger, WTShareType) {
    WTShareTypeWeiXinSession = 0,   // 微信朋友
    WTShareTypeWeiXinTimeline,      // 朋友圈
    WTShareTypeQQ,                  // QQ好友
    WTShareTypeQQZone,              // QQ空间
    WTShareTypeWeiXinFavorite,      // 微信收藏
    WTShareTypeWeiBo,               // 新浪微博
    WTShareTypeWeiMessage,          // 短信
    WTShareTypeWeiEmail,            // 邮件
};

typedef NS_ENUM(NSInteger, WTShareWeiXinErrCode) {
    WTShareWeiXinErrCodeSuccess = 0,   // 新浪微博
    WTShareWeiXinErrCodeCancel = -2,          // QQ好友
    
};

typedef void(^WTShareResultlBlock)(NSString * shareResult);

@interface FSShareManager : NSObject <WBHttpRequestDelegate,WeiboSDKDelegate,WXApiDelegate,TencentSessionDelegate>


+ (instancetype)shareInstance;
// 判断QQ分享是否成功
+ (void)didReceiveTencentUrl:(NSURL *)url;
+ (void)wt_shareWithContent:(WTShareContentItem *)contentObj shareType:(WTShareType)shareType shareResult:(WTShareResultlBlock)shareResult;

@end
