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

/*
    @param frame:全屏，最好是self.view.bounds或[UIScreen mainScreen].bounes
    @param list:类型数组，需要哪些就传入哪些
    @parma controller:视图控制器，弹出view
    @param completion:分享结果回调
 
    @param recipients:邮件或短信用，接收人
    @param fileData:邮件或短信用，文件字节流
    @param fileName:邮件或短信用，文件名
 
    文件类型:@"image/jpeg"    @"text/txt"     @"text/doc"     @"file/pdf"
 */
- (instancetype)initWithFrame:(CGRect)frame list:(NSArray<NSNumber *> *)list controller:(UIViewController *)controller title:(NSString *)title detail:(NSString *)detail url:(NSString *)url thumbImage:(UIImage *)image recipientsOfMail:(NSArray<NSString *> *)recipientsOfMail recipientsOfMessage:(NSArray<NSString *> *)recipientsOfMessage fileData:(NSData *)fileData fileName:(NSString *)fileName fileType:(NSString *)fileType result:(void(^)(NSString *bResult))completion;

@end
