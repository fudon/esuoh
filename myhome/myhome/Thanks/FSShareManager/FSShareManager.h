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

typedef NS_ENUM(NSInteger, FSShareType) {
    FSShareTypeQQ = 0,      //  QQ好友
    FSShareTypeQQZone,      //  QQ空间
    FSShareTypeWechat,      //  微信好友
    FSShareTypeWXFriends,   //  微信朋友圈
    FSShareTypeWXStore,     //  微信收藏
    FSShareTypeWeibo,       //  微博
    FSShareTypeMessage,     //  短信
    FSShareTypeEmail        //  电子邮件
};

typedef NS_ENUM(NSInteger, WTShareWeiXinErrCode) {
    WTShareWeiXinErrCodeSuccess = 0,   // 新浪微博
    WTShareWeiXinErrCodeCancel = -2,          // QQ好友
    
};

typedef void(^WTShareResultlBlock)(NSString * shareResult);

@interface FSShareManager : NSObject <WBHttpRequestDelegate,WeiboSDKDelegate,WXApiDelegate,TencentSessionDelegate>

@property (nonatomic,weak) UIViewController *callController;

+ (instancetype)shareInstance;
// 判断QQ分享是否成功
+ (void)didReceiveTencentUrl:(NSURL *)url;
+ (void)wt_shareWithContent:(FSShareEntity *)contentObj shareType:(FSShareType)shareType shareResult:(WTShareResultlBlock)shareResult;

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
