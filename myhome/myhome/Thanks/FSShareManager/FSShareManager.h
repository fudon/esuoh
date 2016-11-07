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
#import "FSShareEntity.h"

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
+ (void)wt_shareWithContent:(FSShareEntity *)contentObj shareType:(WTShareType)shareType shareResult:(WTShareResultlBlock)shareResult;

// 短信分享
- (void)messageShareWithMessage:(NSString *)message     // 短信内容
                     recipients:(NSArray *)recipients   // 短信接收者
                     controller:(UIViewController *)controller;

// 邮件分享
- (void)mailShareWithSubject:(NSString *)subject    // 邮件主题
                 messageBody:(NSString *)message    // 邮件正文
                  recipients:(NSArray *)recipients  // 邮件接收者
                    fileData:(NSData *)fileData     // 附件，比如图片
                    fileName:(NSString *)fileName   // 文件名，包含扩展名,eg,account.sqlite
                  controller:(UIViewController *)controller;

@end
