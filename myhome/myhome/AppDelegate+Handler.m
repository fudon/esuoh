//
//  AppDelegate+Handler.m
//  myhome
//
//  Created by fudon on 2017/1/7.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import "AppDelegate+Handler.h"
#import "FSMacro.h"
#import "FSShareManager.h"
#import "ARTabBarController.h"
#import "FSImagePicker.h"

@implementation AppDelegate (Handler)

- (void)handlerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //通知注册后不再走createLN方法，调试时要打开这句(有时发现打开这里仍然不出现通知，是因为手机设置里的通知没打开，下面的通知时间和中国24小时的时间是一样的，没有八小时差别)
    [self registerLocalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [FuData alertViewWithTitle:@"截屏通知" message:@"可以把图片发送到微信" btnTitle:@"发送" handler:^(UIAlertAction *action) {
                                                          UIImage *image = [FSImagePicker theNewestImageFromAlbum];
                                                          if ([image isKindOfClass:[UIImage class]]) {
                                                              [FSShareManager wxImageShareActionWithImage:image controller:nil result:^(NSString *bResult) {
                                                                  [FuData showMessage:bResult];
                                                              }];
                                                          }
                                                          
                                                      } cancelTitle:@"取消" handler:nil completion:nil];
                                                  }];
    
    NSArray *array = @[@"ARHomeController",@"ARToolController",@"HAToolController",@"ARPersonController"];
    NSArray *titles = @[@"首页",@"案例",@"应用",@"我"];
    NSArray *types = @[@(UITabBarSystemItemMostViewed),@(UITabBarSystemItemBookmarks),@(UITabBarSystemItemFavorites),@(UITabBarSystemItemContacts)];
    ARTabBarController *tbController = [[ARTabBarController alloc] initWithClasses:array titles:titles types:types selectedColor:APPCOLOR];
    self.window.rootViewController = tbController;
}

- (void)registerLocalNotification
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
        NSArray *lnArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
        if (lnArray.count > 0) {
            for (UILocalNotification *noti in lnArray) {
                NSString *notiID = noti.userInfo[@"someKey"];
                if (!notiID) {
                    [self createLN];
                }
            }
        }else{
            [self createLN];
        }
    }
}

- (void)createLN
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    //触发通知的时间
    NSDate *now = [formatter dateFromString:@"06:00:00"];
    notification.fireDate = now;
    //时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //通知重复提示的单位，可以是天、周、月
    notification.repeatInterval = NSCalendarUnitDay;
    notification.applicationIconBadgeNumber = 1;
    //通知内容
    notification.alertBody = @"好好学习，天天向上";
    //通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    notification.userInfo = infoDict; //添加额外的信息
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}


@end
