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
#import <MessageUI/MessageUI.h>

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

typedef NS_ENUM(NSInteger, FSShareWeiXinErrCode) {
    FSShareWeiXinErrCodeSuccess = 0,   // 新浪微博
    FSShareWeiXinErrCodeCancel = -2,          // QQ好友
    
};

typedef void(^WTShareResultlBlock)(NSString * shareResult);

@interface FSShareManager : NSObject <WBHttpRequestDelegate,WeiboSDKDelegate,WXApiDelegate,TencentSessionDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic,weak) UIViewController *callController;

+ (instancetype)shareInstance;
// 判断QQ分享是否成功
+ (void)didReceiveTencentUrl:(NSURL *)url;
//+ (void)wt_shareWithContent:(FSShareEntity *)contentObj shareType:(FSShareType)shareType shareResult:(WTShareResultlBlock)shareResult;

+ (void)shareActionWithShareType:(FSShareType)type title:(NSString *)title description:(NSString *)description  thumbImage:(UIImage *)image url:(NSString *)url controller:(UIViewController *)controller result:(void(^)(NSString *bResult))completion;

// 微信分享图片
+ (void)wxImageShareActionWithImageData:(UIImage *)image controller:(UIViewController *)controller result:(void(^)(NSString *bResult))completion;

// 邮件分享
+ (void)emailShareWithSubject:(NSString *)subject messageBody:(NSString *)body recipients:(NSArray *)recipients fileData:(NSData *)data fileName:(NSString *)fileName fileType:(NSString *)fileType controller:(UIViewController *)controller;
// 短信分享
+ (void)messageShareWithMessage:(NSString *)message recipients:(NSArray *)recipients data:(NSData *)fileData fileName:(NSString *)fileName
                       fileType:(NSString *)fileType    // @"image/jpeg"    @"text/txt"     @"text/doc"     @"file/pdf"
                     controller:(UIViewController *)controller;

@end
