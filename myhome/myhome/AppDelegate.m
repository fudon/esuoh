//
//  AppDelegate.m
//  myhome
//
//  Created by fudon on 2016/10/31.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "AppDelegate.h"
#import "ARTabBarController.h"
#import "FSShareManager.h"
#import "AppDelegate+Handler.h"
#import "FSBirthdayController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self handlerApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (application.applicationIconBadgeNumber) {
        application.applicationIconBadgeNumber = 0;
        [self homeHandleDatas];
    }
}

- (void)homeHandleDatas
{
    NSArray *birthdays = [FSBirthdayController todayBirthdays];
    if (birthdays.count) {
        NSMutableString *title = [[NSMutableString alloc] initWithString:@"今天"];
        for (NSArray *array in birthdays) {
            [title appendFormat:@"%@、",array[0]];
        }
        [title deleteCharactersInRange:NSMakeRange(title.length - 1, 1)];
        [title appendFormat:@"过生日"];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:title forKey:@"SomeoneBirthday"];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        NSString *notiID = noti.userInfo[@"someKey"];
        NSString *receiveNotiID = notification.userInfo[@"someKey"];
        if ([notiID isEqualToString:receiveNotiID]) {
            application.applicationIconBadgeNumber -= 1;
        }
    }
}

#pragma mark - 从别的应用回来
// iOS9 以上用这个方法接收
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
//    NSDictionary * dic = options;
    if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.sina.weibo"]) {
        return [WeiboSDK handleOpenURL:url delegate:[FSShareManager shareInstance]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]){
        return [WXApi handleOpenURL:url delegate:[FSShareManager shareInstance]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.mqq"]){
        [FSShareManager didReceiveTencentUrl:url];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

// iOS9 以下用这个方法接收
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSLog(@"%@",url);
    if ([sourceApplication isEqualToString:@"com.sina.weibo"]) {
        return [WeiboSDK handleOpenURL:url delegate:[FSShareManager shareInstance]];
    }else if ([sourceApplication isEqualToString:@"com.tencent.xin"]){
        return [WXApi handleOpenURL:url delegate:[FSShareManager shareInstance]];
    }else if ([sourceApplication isEqualToString:@"com.tencent.mqq"]){
        [FSShareManager didReceiveTencentUrl:url];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}


@end
