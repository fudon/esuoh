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

@implementation AppDelegate (Handler)

- (void)handlerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [FuData alertViewWithTitle:@"截屏通知" message:@"可以把图片发送到微信" btnTitle:@"发送" handler:^(UIAlertAction *action) {
                                                          UIImage *image = note.object;
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

@end
