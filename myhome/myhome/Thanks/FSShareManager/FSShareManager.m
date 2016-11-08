//
//  FSShareManager.m
//  WTShare
//
//  Created by FudonFuchina on 16/9/4.
//  Copyright © 2016年 wutong. All rights reserved.
//

#import "FSShareManager.h"
#import "FSShareEntity.h"
#import <MessageUI/MessageUI.h>
#import "FuSoft.h"

#define kAppKey         @"2045436852"           // 微博
#define kRedirectURI    @"http://www.sina.com"
#define kWeixinAppId    @"wxd930ea5d5a258f4f"
#define kTencentAppId   @"222222"

#define kWTShareQQSuccess @"0"
#define kWTShareQQFail      @"-4"

@interface FSShareManager ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    TencentOAuth *_tencentOAuth;
}

@property (nonatomic, copy)WTShareResultlBlock shareResultlBlock;
@end

@implementation FSShareManager

static FSShareManager *manager = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSShareManager alloc] init];
        [manager setRegisterApps];
    });
    return manager;
}

// 注册appid
- (void)setRegisterApps
{
    // 注册Sina微博
    [WeiboSDK registerApp:kAppKey];
    // 微信注册
    [WXApi registerApp:kWeixinAppId];
    
    // 注册QQ
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:kTencentAppId andDelegate:self];
}

#pragma mark - 分享方法------
+ (void)wt_shareWithContent:(FSShareEntity *)contentObj shareType:(FSShareType)shareType shareResult:(WTShareResultlBlock)shareResult
{
    FSShareManager * shareManager = [FSShareManager shareInstance];
    shareManager.shareResultlBlock = shareResult;
    
    [self wt_shareWithContent:contentObj shareType:shareType];
}

+ (void)wt_shareWithContent:(FSShareEntity *)contentObj shareType:(FSShareType)shareType
{
    [FSShareManager shareInstance];
    
    BOOL canStep = [self canSupportShare:shareType];
    if (!canStep) {
        return;
    }
    
    switch (shareType) {
        case FSShareTypeWeibo:
        {
            WBMessageObject *message = [WBMessageObject message];
            message.text = contentObj.sinaSummary;
            
            if(contentObj.bigImage){
                WBImageObject *webpage = [WBImageObject object];
                webpage.imageData =  UIImageJPEGRepresentation(contentObj.bigImage, 1.0f);
                
                message.imageObject = webpage;
            }
            
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
            
            [WeiboSDK sendRequest:request];
            break;
        }
        case FSShareTypeQQ:
        {
            NSString * shareTitle = [NSString string];
            shareTitle = contentObj.qqTitle ? contentObj.qqTitle : contentObj.title;
            
            //分享跳转URL
            NSString *urlt = contentObj.urlString;
            QQApiNewsObject * newsObj ;
            
            if (contentObj.urlImageString) {
                newsObj   = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlt] title:shareTitle description:contentObj.summary previewImageURL:[NSURL URLWithString:contentObj.urlImageString]];
            }else if(contentObj.thumbImage){
                // 如果分享的是图片的话 不能太大所以如果后台过来的的图片太大的话 可以调节如下的倍数
                NSData *imageData = UIImageJPEGRepresentation(contentObj.thumbImage, 1.0);
                newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlt] title:shareTitle description:contentObj.summary previewImageData:imageData];
            }
            
            SendMessageToQQReq *req = [[SendMessageToQQReq alloc] init];
            req.message = newsObj;
            req.type = ESENDMESSAGETOQQREQTYPE;
            //将内容分享到qq
            [QQApiInterface sendReq:req];
            break;
        }
        case FSShareTypeQQZone:
        {
            //分享跳转URL
            NSString *urlt = contentObj.urlString;
            
            QQApiNewsObject * newsObj ;
            if (contentObj.urlImageString) {
                newsObj   = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlt] title:contentObj.title description:contentObj.summary previewImageURL:[NSURL URLWithString:contentObj.urlImageString]];
            }else if(contentObj.thumbImage){
                
                NSData * imageData = UIImagePNGRepresentation(contentObj.thumbImage);
                
                newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlt] title:contentObj.title description:contentObj.summary previewImageData:imageData];
            }
            
            SendMessageToQQReq *req = [[SendMessageToQQReq alloc]init];
            req.message = newsObj;
            req.type = ESENDMESSAGETOQQREQTYPE;
            
            [QQApiInterface SendReqToQZone:req];
            break;
            
            break;
        }
        case FSShareTypeWXFriends: // 微信朋友圈
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.weixinPyqtitle.length >0 ? contentObj.weixinPyqtitle : contentObj.title;
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            WXWebpageObject * ext = [WXWebpageObject object];
            ext.webpageUrl = contentObj.urlString;
            message.mediaObject = ext;
            SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
            
            
            break;
        }
        case FSShareTypeWechat:
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.title;
            
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            WXWebpageObject * ext = [WXWebpageObject object];
            ext.webpageUrl = contentObj.urlString;
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
            
            break;
        }
        case FSShareTypeWXStore:
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.title;
            
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            WXWebpageObject * ext = [WXWebpageObject object];
            ext.webpageUrl = contentObj.urlString;
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneFavorite;
            [WXApi sendReq:req];
            break;
        }
            
        default:
            break;
    }
}

+ (BOOL)canSupportShare:(FSShareType)shareType
{
    if (shareType == FSShareTypeWechat || shareType == FSShareTypeWXFriends || shareType == FSShareTypeWXStore) {
        return [self canSupportShareWX];
    }
    if (shareType == FSShareTypeWeibo) {
        return [self canSupportShareWB];
    }
    if (shareType == FSShareTypeQQ || shareType == FSShareTypeQQZone) {
        return [self canSupportShareQQ];
    }
    return NO;
}

+ (BOOL)canSupportShareWX
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        return YES;
    }
    [FuData alertViewAtController:[FSShareManager shareInstance].callController title:@"未安装最新版微信" message:@"是否去下载最新版微信" cancelTitle:@"取消" handler:nil okTitle:@"下载" handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
    } completion:nil];
    return NO;
}

+ (BOOL)canSupportShareWB
{
    if ([WeiboSDK isCanShareInWeiboAPP]) {
        return YES;
    }
    [FuData alertViewAtController:[FSShareManager shareInstance].callController title:@"未安装最新版微博" message:@"是否去下载最新版微博" cancelTitle:@"取消" handler:nil okTitle:@"下载" handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WeiboSDK getWeiboAppInstallUrl]]];
    } completion:nil];
    return NO;
}

+ (BOOL)canSupportShareQQ
{
    if ([QQApiInterface isQQSupportApi]) {
        return YES;
    }
    [FuData alertViewAtController:[FSShareManager shareInstance].callController title:@"未安装最新版QQ" message:@"是否去下载最新版QQ" cancelTitle:@"取消" handler:nil okTitle:@"下载" handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[QQApiInterface getQQInstallUrl]]];
    } completion:nil];
    return NO;
}

#pragma mark - WeiboSDKDelegate 从新浪微博那边分享过来传回一些数据调用的方法
/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{}
/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    /**
     
     WeiboSDKResponseStatusCodeSuccess               = 0,//成功
     WeiboSDKResponseStatusCodeUserCancel            = -1,//用户取消发送
     WeiboSDKResponseStatusCodeSentFail              = -2,//发送失败
     WeiboSDKResponseStatusCodeAuthDeny              = -3,//授权失败
     WeiboSDKResponseStatusCodeUserCancelInstall     = -4,//用户取消安装微博客户端
     WeiboSDKResponseStatusCodePayFail               = -5,//支付失败
     WeiboSDKResponseStatusCodeShareInSDKFailed      = -8,//分享失败 详情见response UserInfo
     WeiboSDKResponseStatusCodeUnsupport             = -99,//不支持的请求
     WeiboSDKResponseStatusCodeUnknown               = -100,
     */
    
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        //NSLog(@"微博----分享成功!!!");
        self.shareResultlBlock(@"微博----分享成功!!!");
        
    }else if(response.statusCode == WeiboSDKResponseStatusCodeUserCancel)
    {
        //        NSLog(@"微博----用户取消发送");
        self.shareResultlBlock(@"微博----用户取消发送");
    }else if (response.statusCode == WeiboSDKResponseStatusCodeSentFail){
        //        NSLog(@"微博----发送失败!");
        self.shareResultlBlock(@"微博----发送失败!");
    }
    
    
    //    NSLog(@"%@", response);
}


#pragma mark - WXApiDelegate 从微信那边分享过来传回一些数据调用的方法


/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp 具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp
{
    
    // 成功回来
    // errCode  0
    // type     0
    
    // 取消分享回来
    // errCode -2
    // type 0
    
    if (resp.errCode == WTShareWeiXinErrCodeSuccess) {
        //        NSLog(@"微信----分享成功!!");
        self.shareResultlBlock(@"微信----分享成功!!");
    }else{
        //        NSLog(@"微信----用户取消分享!!");
        self.shareResultlBlock(@"微信----用户取消分享!!");
    }
    //    NSLog(@"%@", resp);
    
}

#pragma mark - 判断qq是否分享成功
+ (void)didReceiveTencentUrl:(NSURL *)url
{
    NSString * urlStr = url.absoluteString;
    NSArray * array = [urlStr componentsSeparatedByString:@"error="];
    if (array.count > 1) {
        NSString * lastStr = [array lastObject];
        NSArray * lastStrArray = [lastStr componentsSeparatedByString:@"&"];
        
        NSString * resultStr = [lastStrArray firstObject];
        if ([resultStr isEqualToString:kWTShareQQSuccess]) {
            //            NSLog(@"QQ------分享成功!");
            [FSShareManager shareInstance].shareResultlBlock(@"QQ------分享成功!");
        }else if ([resultStr isEqualToString:kWTShareQQFail]){
            //            NSLog(@"QQ------分享失败!");
            [FSShareManager shareInstance].shareResultlBlock(@"QQ------分享失败!");
        }
        
    }
}

- (void)tencentDidLogin
{
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void)messageShareWithMessage:(NSString *)message     // 短信内容
                     recipients:(NSArray *)recipients   // 短信接收者
                     controller:(UIViewController *)controller
{
    if (![MFMessageComposeViewController canSendText]) {
        [FuData showMessage:@"设备不支持发送短信"];
        return;
    }
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    if (recipients) {
        picker.recipients = recipients;
    }

    if (message) {
        picker.body = message;
    }
    if (picker) {
        [controller presentViewController:picker animated:YES completion:nil];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultSent:
        {
            [FuData showMessage:@"发送成功"];
        }
            break;
            
        case MessageComposeResultFailed:
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailShareWithSubject:(NSString *)subject    // 邮件主题
                 messageBody:(NSString *)message    // 邮件正文
                  recipients:(NSArray *)recipients  // 邮件接收者
                    fileData:(NSData *)fileData     // 附件，比如图片
                    fileName:(NSString *)fileName   // 文件名，包含扩展名,eg,account.sqlite
                  controller:(UIViewController *)controller

{
    if (![MFMailComposeViewController canSendMail]) {
        [FuData showMessage:@"设备不支持发送邮件"];
        return;
    }
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    if (recipients) {
        [picker setToRecipients:recipients];
    }
    if (subject) {
        [picker setSubject:subject];
    }
    if (fileData) {
        [picker addAttachmentData:fileData mimeType:@"" fileName:fileName?fileName:[[NSDate date] description]];
    }
    if (message) {
        [picker setMessageBody:message isHTML:NO];
    }
    [controller presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (result == MFMailComposeResultSent) {
        [FuData showMessage:@"邮件发送成功"];
    }else if (result == MFMailComposeResultFailed){
        [FuData showMessage:@"邮件发送失败"];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
