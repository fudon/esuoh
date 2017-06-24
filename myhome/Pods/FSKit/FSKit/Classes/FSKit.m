//
//  FSKit.m
//  Pods
//
//  Created by fudon on 2017/6/17.
//
//

#import "FSKit.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "FuSoft.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "sys/utsname.h"
#include <net/if.h>
#include <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AVFoundation/AVFoundation.h>
#import <sys/mount.h>

#define DESKEY @"D6D2402F1C98E208FF2E863AA29334BD65AE1932A821502D9E5673CDE3C713ACFE53E2103CD40ED6BEBB101B484CAE83D537806C6CB611AEE86ED2CA8C97BBE95CF8476066D419E8E833376B850172107844D394016715B2E47E0A6EECB3E83A361FA75FA44693F90D38C6F62029FCD8EA395ED868F9D718293E9C0E63194E87"

static CGRect oldframe;

@implementation FSKit

//#import "FuSoft-Swift.h"        // Swift工程

+ (void)presentAlertViewController:(UIAlertController *)alertController completion:(void (^)(void))completion
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:completion];
}

+ (void)alertView1WithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle handler:(void (^)(UIAlertAction *action))handler completion:(void (^)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title?title:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    BOOL validateString = [self isValidateString:btnTitle];
    UIAlertAction *aAction = [UIAlertAction actionWithTitle:validateString?btnTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(action);
        }
    }];
    [alertController addAction:aAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle handler:(void (^)(UIAlertAction *action))okHandler cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))handler completion:(void (^)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:okHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:handler];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message destructTitle:(NSString *)btnTitle handler:(void (^)(UIAlertAction *action))destructHandler cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDestructive handler:destructHandler];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)actionSheet1WithTitle:(NSString *)title firstTitle:(NSString *)firstTitle style:(UIAlertActionStyle)style firstHandler:(void (^)(UIAlertAction *action))firstHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:style handler:^(UIAlertAction * _Nonnull action) {
        if (firstHandler) {
            firstHandler(action);
        }
    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:firstAction];
    [controller addAction:archiveAction];
    [self presentAlertViewController:controller completion:completion];
}

+ (void)actionSheet2WithTitle:(NSString *)title firstTitle:(NSString *)firstTitle style:(UIAlertActionStyle)firstStyle firstHandler:(void (^)(UIAlertAction *action))firstHandler secondTitle:(NSString *)secondTitle style:(UIAlertActionStyle)secondStyle handler:(void (^)(UIAlertAction *action))secondHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:firstStyle handler:^(UIAlertAction * _Nonnull action) {
        if (firstHandler) {
            firstHandler(action);
        }
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:secondStyle handler:^(UIAlertAction * _Nonnull action) {
        if (secondHandler) {
            secondHandler(action);
        }
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:firstAction];
    [controller addAction:secondAction];
    [controller addAction:archiveAction];
    
    [self presentAlertViewController:controller completion:completion];
}

+ (void)actionSheet3WithTitle:(NSString *)title firstTitle:(NSString *)firstTitle style:(UIAlertActionStyle)firstStyle firstHandler:(void (^)(UIAlertAction *action))firstHandler secondTitle:(NSString *)secondTitle style:(UIAlertActionStyle)secondStyle handler:(void (^)(UIAlertAction *action))secondHandler thirdTitle:(NSString *)third style:(UIAlertActionStyle)thirdStyle handler:(void (^)(UIAlertAction *action))thrHandler  cancelHandler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:firstStyle handler:^(UIAlertAction * _Nonnull action) {
        if (firstHandler) {
            firstHandler(action);
        }
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:secondStyle handler:^(UIAlertAction * _Nonnull action) {
        if (secondHandler) {
            secondHandler(action);
        }
    }];
    
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:third style:thirdStyle handler:^(UIAlertAction * _Nonnull action) {
        if (thrHandler) {
            thrHandler(action);
        }
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:firstAction];
    [controller addAction:secondAction];
    [controller addAction:thirdAction];
    [controller addAction:archiveAction];
    
    [self presentAlertViewController:controller completion:completion];
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^ __nullable)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^ __nullable)(UIAlertAction *action))handler destructTitle:destructTitle handler:(void (^ __nullable)(UIAlertAction *action))destructHandler completion:(void (^ __nullable)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDestructive handler:handler];
    UIAlertAction *destructAction = [UIAlertAction actionWithTitle:destructTitle style:UIAlertActionStyleDestructive handler:destructHandler];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addAction:destructAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)alertViewInputWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^ __nullable)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^ __nullable)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^ __nullable)(UITextField *textField))configurationHandler completion:(void (^ __nullable)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (configurationHandler) {
            configurationHandler(textField);
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(alertController,action);
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)alertViewInputsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^ __nullable)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^ __nullable)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^ __nullable)(UITextField *textField))configurationHandler textFieldConifg:(void (^ __nullable)(UITextField *textField))configuration completion:(void (^ __nullable)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (configurationHandler) {
            configurationHandler(textField);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (configuration) {
            configuration(textField);
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(alertController,action);
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)alertView3InputsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^ __nullable)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^ __nullable)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^ __nullable)(UITextField *textField))firstConfig textFieldConifg:(void (^ __nullable)(UITextField *textField))secondConfig textFieldConifg:(void (^ __nullable)(UITextField *textField))thirdConfig completion:(void (^ __nullable)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (firstConfig) {
            firstConfig(textField);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (secondConfig) {
            secondConfig(textField);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (thirdConfig) {
            thirdConfig(textField);
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(alertController,action);
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)alertViewFourInputsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^ __nullable)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^ __nullable)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^ __nullable)(UITextField *textField))firstConfig textFieldConifg:(void (^ __nullable)(UITextField *textField))secondConfig textFieldConifg:(void (^ __nullable)(UITextField *textField))thirdConfig textFieldConifg:(void (^ __nullable)(UITextField *textField))forthConfig completion:(void (^ __nullable)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (firstConfig) {
            firstConfig(textField);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (secondConfig) {
            secondConfig(textField);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (thirdConfig) {
            thirdConfig(textField);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (forthConfig) {
            forthConfig(textField);
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(alertController,action);
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentAlertViewController:alertController completion:completion];
}

+ (void)pushToViewControllerWithClass:(NSString *)className navigationController:(UINavigationController *)navigationController param:(NSDictionary *)param configBlock:(void (^)(id vc))configBlockParam
{
    Class Controller = NSClassFromString(className);
    if (Controller) {
        UIViewController *viewController = [[Controller alloc] init];
        //... 根据字典给属性赋值
        for (NSString *key in param) {
            SEL setSEL = [self setterSELWithAttibuteName:key];
            if ([viewController respondsToSelector:setSEL]) {
                [viewController performSelector:setSEL onThread:[NSThread currentThread] withObject:[param objectForKey:key] waitUntilDone:YES];
            }
        }
        
        if (configBlockParam) {
            configBlockParam(viewController);
        }
        [navigationController pushViewController:viewController animated:YES];
    }
}

+ (void)presentToViewControllerWithClass:(NSString *)className controller:(UIViewController *)viewController param:(NSDictionary *)param configBlock:(void (^)(UIViewController *vc))configBlockParam presentCompletion:(void(^)(void))completion
{
    Class Controller = NSClassFromString(className);
    if (Controller) {
        UIViewController *presentViewController = [[Controller alloc] init];
        //... 根据字典给属性赋值
        for (NSString *key in param) {
            SEL setSEL = [self setterSELWithAttibuteName:key];
            if ([viewController respondsToSelector:setSEL]) {
                [viewController performSelectorOnMainThread:setSEL
                                                 withObject:[param objectForKey:key]
                                              waitUntilDone:[NSThread isMainThread]];
            }
        }
        if (configBlockParam) {
            configBlockParam(presentViewController);
        }
        [viewController presentViewController:presentViewController animated:YES completion:completion];
    }
}

+ (void)copyToPasteboard:(NSString *)copyString
{
    if (copyString == nil) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:copyString];
}

+ (void)playSongs:(NSString *)songs type:(NSString *)fileType
{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:songs ofType:fileType]], &soundID);
    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);// 播放震动
}

+ (void)xuanzhuanView:(UIView *)view
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

+ (void)userDefaultsKeepData:(id)instance  withKey:(NSString *)key
{
    NSUserDefaults *fdd = [NSUserDefaults standardUserDefaults];
    [fdd setObject:instance forKey:key];
    [fdd synchronize];
}

+ (id)userDefaultsDataWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)showFullScreenImage:(UIImageView *)avatarImageView
{
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    }completion:^(BOOL finished) {
        
    }];
}

+ (void)hideImage:(UITapGestureRecognizer*)tap
{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha=0;
    }completion:^(BOOL finished) {
        [backgroundView
         removeFromSuperview];
    }];
}

+ (void)clearUserDefaults
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defs dictionaryRepresentation];
    for(id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

+ (void)letScreenLock:(BOOL)lock
{
    [UIApplication sharedApplication].idleTimerDisabled = !lock;
}

+ (void)gotoAppCentPageWithAppId:(NSString *)appID
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appID]]];
}

+ (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}

+ (void)showMessage:(NSString *)message
{
    if (![message respondsToSelector:@selector(length)] || [message length] == 0) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showMessageInMainThread:message];
    });
}

+ (void)showAlertWithMessage:(NSString *)message
{
    [self alertView1WithTitle:@"提示" message:message btnTitle:@"确定" handler:nil completion:nil];
}

+ (void)showMessageInMainThread:(NSString *)message
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTHFC, HEIGHTFC - 64)];
    
    CGFloat width = WIDTHFC - 60;
    CGFloat height = MAX([self textHeight:message fontInt:15 labelWidth:width], 36);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHFC / 2 - width / 2, HEIGHTFC / 2 - height / 2, width, height)];
    label.text = message;
    label.backgroundColor = RGBCOLOR(0, 0, 0, .8);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = FONTFC(15);
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 3;
    [backView addSubview:label];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:backView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [backView removeFromSuperview];
        }];
    });
}

+ (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

+ (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

+ (float)folderSizeAtPath:(NSString*)folderPath extension:(NSString *)extension
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        if (extension) {
            if ([[fileAbsolutePath pathExtension] isEqualToString:extension]) {
                folderSize += [self fileSizeAtPath:fileAbsolutePath];
            }
        }else{
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
    }
    //    return folderSize / (1024.0 * 1024.0);
    return folderSize / 1024.0;
}

+ (long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (CGFloat)textHeight:(NSString *)text fontInt:(NSInteger)fontInt labelWidth:(CGFloat)labelWidth
{
    if (fontInt == 0) {
        [self showMessage:@"fontInt不能为0"];
        return 0;
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange allRange = [text rangeOfString:text];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:fontInt]
                    range:allRange];
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
                                        options:options
                                        context:nil];
    //    return titleHeight + 2;  // 加两个像素,防止emoji被切掉.
    return ceilf(rect.size.height);
}

+ (double)distanceBetweenCoordinate:(CLLocationCoordinate2D)coordinateA toCoordinateB:(CLLocationCoordinate2D)coordinateB
{
    static double EARTH_RADIUS = 6378.137;//地球半径
    
    double lat1 = coordinateA.latitude;
    double lng1 = coordinateA.longitude;
    double lat2 = coordinateB.latitude;
    double lng2 = coordinateB.longitude;
    
    double radLat1 = [self rad:lat1];
    double radLat2 = [self rad:lat2];
    double a = radLat1 - radLat2;
    double b = [self rad:lng1] - [self rad:lng2];
    
    double s = 2 * sin(sqrt(pow(sin(a/2),2) + cos(radLat1) * cos(radLat2)* pow(sin(b/2),2)));
    s = s * EARTH_RADIUS;
    s = round(s * 10000) / 10000;
    return s;
}

//磁盘总空间
+ (CGFloat)diskOfAllSizeBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue];
    }
    return size;
}

//磁盘可用空间
+ (CGFloat)diskOfFreeSizeBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue];
    }
    return size;
}

//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeAtPath:filePath];
    }
    return folerSize;
}

// 获取当前设备可用内存(单位：MB）
+ (double)availableMemoryNew
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return vm_page_size *vmStats.free_count;
}

// 获取当前任务所占用的内存（单位：MB）
+ (double)currentAppMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size;
}

+ (CGSize)keyboardNotificationScroll:(NSNotification *)notification baseOn:(CGFloat)baseOn
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        return CGSizeMake(WIDTHFC, MAX(keyboardSize.height + baseOn, HEIGHTFC));
    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]){
        return  CGSizeMake(WIDTHFC, MAX(baseOn, HEIGHTFC));
    }
    return CGSizeZero;
}

/*
 等额本金计算公式
 rate:年利率，如4.9%，输入4.9；
 month:期数，也就是月数，如10年，输入120
 返回值：总还款除以贷款的倍数
 */
+ (CGFloat)DEBJWithYearRate:(CGFloat)rate monthes:(NSInteger)month
{
    if (rate < 0.01) {
        return 1;
    }
    CGFloat money = 1.0;
    CGFloat R = rate / 1200.0f;
    
    CGFloat allInterest = 0;
    double payMonth = money / month;
    for (int x = 0; x < month; x ++) {
        double mI = (money - x * payMonth) * R; // 每月的利息；加上payMonth就是每月的还款额
        allInterest += mI;
    }
    return (money + allInterest) / money;
}

/*
 等额本息计算公式
 rate:年利率，如4.9%，输入4.9；
 month:期数，也就是月数，如10年，输入120
 返回值：总还款除以贷款的倍数
 */
+ (CGFloat)DEBXWithYearRate:(CGFloat)rate monthes:(NSInteger)month
{
    if (rate < 0.01) {
        return 1;
    }
    CGFloat money = 1.0f;
    CGFloat R = rate / 1200.0f;
    // 等额本息
    double monthPay = (money * R * pow(1 + R, month)) / (pow(1 + R, month) - 1);
    return monthPay * month / money;
}

+ (CGFloat)freeStoragePercentage
{
    CGFloat total = [self getTotalDiskSize];
    if (total > 1) {
        return [self getAvailableDiskSize] / total;
    }
    return 0;
}

+ (NSInteger)getTotalDiskSize   // 获取磁盘总量
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return (NSInteger)freeSpace;
}

+ (NSInteger)getAvailableDiskSize   // 获取磁盘可用量
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return (NSInteger)freeSpace;
}

+ (double)rad:(double)d
{
    return d * 3.141592653 / 180.0;
}

+ (NSArray *)maxandMinNumberInArray:(NSArray *)array
{
    if (array.count == 0) {
        return nil;
    }
    int i;
    double max = [array[0] doubleValue];
    double min = max;
    
    for (i = 1; i < array.count; i++)
    {
        CGFloat number = [array[i] doubleValue];
        
        if (number > max)
            max = number;
        
        if (number < min)
            min = number;
    }
    return @[@(max),@(min)];
}

+ (NSArray *)maopaoArray:(NSArray *)array
{
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:array];
    for (int x = 0; x < mArray.count - 1; x ++) {
        for (int y = 0; y < mArray.count - 1 - x; y ++) {
            double first = [mArray[y] floatValue];
            double second = [mArray[y + 1] floatValue];
            if (first > second) {
                double temp = first;
                [mArray replaceObjectAtIndex:y withObject:@(second)];
                [mArray replaceObjectAtIndex:y+1 withObject:@(temp)];
            }
        }
    }
    return mArray;
}

+ (NSArray *)addCookies:(NSArray *)nameArray value:(NSArray *)valueArray cookieDomain:(NSString *)cookName
{
    if (nameArray.count != valueArray.count) {
        return nil;
    }
    NSMutableArray *cookieArray = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < nameArray.count; x ++) {
        NSMutableDictionary *cookieProperties = [[NSMutableDictionary alloc] init];
        [cookieProperties setObject:nameArray[x] forKey:NSHTTPCookieName];
        [cookieProperties setObject:valueArray[x] forKey:NSHTTPCookieValue];
        [cookieProperties setObject:cookName forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:cookName forKey:NSHTTPCookieOriginURL];
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [cookieArray addObject:cookie];
    }
    return cookieArray;
}

+ (NSArray *)deviceInfos
{
    NSString *name = @"name";
    NSString *value = @"value";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    UIDevice *device = [UIDevice currentDevice];
    NSDictionary *dic0 = @{name:@"我的设备",value:device.name};
    //    NSDictionary *dic1 = @{name:@"手机模型",value:device.model};
    //    NSDictionary *dic2 = @{name:@"本地模型",value:device.localizedModel};
    NSDictionary *dic3 = @{name:@"系统版本",value:[[NSString alloc] initWithFormat:@"%@%@",device.systemName,device.systemVersion]};
    NSDictionary *dic4 = @{name:@"唯一标识符",value:[[[UIDevice currentDevice] identifierForVendor] UUIDString]};
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = rect.size.width * scale;
    CGFloat height = rect.size.height * scale;
    NSDictionary *dic5 = @{name:@"屏幕分辨率",value:[[NSString alloc] initWithFormat:@"%@ x %@",@(width),@(height)]};
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    NSDictionary *dic6 = @{name:@"运营商",value:mCarrier};
    NSDictionary *dic7 = @{name:@"网络类型",value:[self networkTypeForType:info.currentRadioAccessTechnology]};
    NSDictionary *dic8 = @{name:@"电池信息",value:[self getBatteryState]};
    NSDictionary *dic9 = @{name:@"电量",value:@(device.batteryLevel).stringValue};
    NSDictionary *dic10 = @{name:@"iP地址",value:[self iPAddress]};
    //    NSDictionary *dic12 = @{name:@"内存",value:[self kMGTUnit:[NSProcessInfo processInfo].physicalMemory]};
    //    NSDictionary *dic13 = @{name:@"可用内存",value:[self kMGTUnit:[self getAvailableMemorySize]]};
    NSDictionary *dic14 = @{name:@"磁盘总量",value:[self KMGUnit:[self getTotalDiskSize]]};
    NSDictionary *dic15 = @{name:@"磁盘可用空间",value:[self KMGUnit:[self getAvailableDiskSize]]};
    
    [array addObject:dic0];
    //    [array addObject:dic1];
    //    [array addObject:dic2];
    [array addObject:dic3];
    [array addObject:dic4];
    [array addObject:dic5];
    [array addObject:dic6];
    [array addObject:dic7];
    [array addObject:dic8];
    [array addObject:dic9];
    [array addObject:dic10];
    //    [array addObject:dic12];
    //    [array addObject:dic13];
    [array addObject:dic14];
    [array addObject:dic15];
    return array;
}

/*
 CTRadioAccessTechnologyGPRS
 CTRadioAccessTechnologyEdge
 CTRadioAccessTechnologyWCDMA
 CTRadioAccessTechnologyHSDPA
 CTRadioAccessTechnologyHSUPA
 CTRadioAccessTechnologyCDMA1x
 CTRadioAccessTechnologyCDMAEVDORev0
 CTRadioAccessTechnologyCDMAEVDORevA
 CTRadioAccessTechnologyCDMAEVDORevB
 CTRadioAccessTechnologyeHRPD
 CTRadioAccessTechnologyLTE
 */
+ (NSString *)networkTypeForType:(NSString *)type
{
    if ([type isEqualToString:CTRadioAccessTechnologyGPRS]) {
        return @"GPRS(2.5G)";
    }else if ([type isEqualToString:CTRadioAccessTechnologyEdge]){
        return @"Edge(2.75G)";
    }else if ([type isEqualToString:CTRadioAccessTechnologyWCDMA]){
        return @"WCDMA(3G)";
    }else if ([type isEqualToString:CTRadioAccessTechnologyHSDPA]){
        return @"HSDPA(3.5G)";
    }else if ([type isEqualToString:CTRadioAccessTechnologyHSUPA]){
        return @"HSUPA";
    }else if ([type isEqualToString:CTRadioAccessTechnologyCDMA1x]){
        return @"CDMA1x";
    }else if ([type isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]){
        return @"CDMAEVDORev0";
    }else if ([type isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]){
        return @"CDMAEVDORevA";
    }else if ([type isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]){
        return @"CDMAEVDORevB";
    }else if ([type isEqualToString:CTRadioAccessTechnologyeHRPD]){
        return @"HRPD";
    }else if ([type isEqualToString:CTRadioAccessTechnologyLTE]){
        return @"LTE(4G)";
    }else{
        if (type == nil) {
            return @"例外";
        }
        return type;
    }
}

+ (long long)getAvailableMemorySize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

+ (NSString*)getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"未知";
    }else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"未充电";
    }else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"充电";
    }else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"电量已满";
    }
    return nil;
}

+ (NSString *)appVersionNumber
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appName
{
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    if (name.length == 0) {
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        name = [infoDict objectForKey:@"CFBundleDisplayName"];
    }
    return name;
}

+ (NSArray<NSString *> *)propertiesForClass:(Class)className
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(className, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);//获取属性名字
        NSString *nameToString = [[NSString alloc] initWithFormat:@"%s",name];
        [array addObject:nameToString];
    }
    return array;
}

+ (SEL)setterSELWithAttibuteName:(NSString*)attributeName
{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

+ (NSString *)valueForGetSelectorWithPropertyName:(NSString *)name object:(id)instance
{
    if (![name isKindOfClass:[NSString class]]) {
        return nil;
    }
    SEL getSelector = NSSelectorFromString(name);
    if ([instance respondsToSelector:getSelector]) {
        IMP imp = [instance methodForSelector:getSelector];
        NSString* (*func)(id, SEL) = (void *)imp;
        NSString *value = func(instance, getSelector);
        return value;
    }
    return nil;
}

+ (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIFont *)angleFontWithRate:(CGFloat)rate fontSize:(NSInteger)fontSize
{
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(rate * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:fontSize].fontName matrix:matrix];
    UIFont *font = [UIFont fontWithDescriptor:desc size:fontSize];
    return font;
}

+ (NSDate *)dateFromStringByHotline:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if ([string isKindOfClass:[NSString class]] && string.length == 0) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600]];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date= [dateFormatter dateFromString:string];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return localeDate;
}

+ (NSDate *)dateFromStringByHotlineWithoutSeconds:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if ([string isKindOfClass:[NSString class]] && string.length == 0) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date= [dateFormatter dateFromString:string];
    return date;
}

+ (NSDate *)chinaDateByDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [date dateByAddingTimeInterval: interval];
}

+ (NSDate *)chinaDateByTimeInterval:(NSString *)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [date dateByAddingTimeInterval: interval];
}

+ (NSDateComponents *)componentForDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return components;
}

+ (NSInteger)daythOfYearForDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateComponents *component = [self componentForDate:date];
    NSInteger year = component.year;
    NSInteger month = component.month;
    NSInteger day = component.day;
    int a[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    int b[12]={31,29,31,30,31,30,31,31,30,31,30,31};
    int i,sum=0;
    if([self isLeapYear:(int)year])
        for(i=0;i<month-1;i++)
            sum+=b[i];
    else
        for(i=0;i<month-1;i++)
            sum+=a[i];
    sum+=day;
    return sum;
}

/*
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color
{
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

+ (UIImage *)QRImageFromString:(NSString *)sourceString
{
    if (sourceString == nil) {
        sourceString = @"";
    }
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *ciImage = [filter outputImage];
    //UIImage *unsharpImage = [UIImage imageWithCIImage:ciImage];//不清晰
    
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:ciImage withSize:960];
    return image;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    CGContextSetLineWidth(context,2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    //在圆区域内画出image原图
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    
    //生成新的image
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (NSURL *)convertTxtEncoding:(NSURL *)fileUrl
{
    NSString *filePath = [fileUrl path];
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        if ( [[manager attributesOfItemAtPath:filePath error:nil] fileSize] > 1024*1024.0f) {
            return fileUrl;
        }
    }
    
    NSString *tmpFilePath = [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), [fileUrl lastPathComponent]];
    NSURL *tmpFileUrl = [NSURL fileURLWithPath:tmpFilePath];
    NSStringEncoding encode;
    NSString *contentStr = [NSString stringWithContentsOfURL:fileUrl usedEncoding:&encode error:NULL];
    
    if (contentStr)
    {
        [contentStr writeToURL:tmpFileUrl atomically:YES encoding:NSUTF16StringEncoding error:NULL];
        return tmpFileUrl;
    }else{
        NSStringEncoding convertEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        contentStr = [NSString stringWithContentsOfURL:fileUrl encoding:convertEncoding error:NULL];
        
        if (contentStr)
        {
            [contentStr writeToURL:tmpFileUrl atomically:YES encoding:NSUTF16StringEncoding error:NULL];
            
            return tmpFileUrl;
        }
        else
        {
            return fileUrl;
        }
    }
}

+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL
{
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

+ (id)storyboardInstantiateViewControllerWithStoryboardID:(NSString *)storybbordID
{
    if (storybbordID == nil) {
        return nil;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [sb instantiateViewControllerWithIdentifier:storybbordID];
}

+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    if (sourceImage.size.width < defineWidth) {
        return sourceImage;
    }
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth
{
    CGFloat sourceWidth = sourceImage.size.width;
    CGFloat sourceHeight = sourceImage.size.height;
    CGFloat targetHeight = (targetWidth / sourceWidth) * sourceHeight;
    
    CGFloat compressRate = sourceWidth * sourceHeight / (targetWidth * targetHeight);
    if (compressRate <= 1.0f) {
        return sourceImage;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

#pragma mark - 对图片进行模糊处理
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter;
    if (name.length != 0) {
        filter = [CIFilter filterWithName:name];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![name isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return nil;
    }
}

/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

//全屏截图
+ (UIImage *)shotFullScreen
{
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    UIGraphicsBeginImageContext(window.bounds.size);
    //    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return image;
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, NO, 0.0); // no ritina
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        if(window == screenWindow)
        {
            break;
        }else{
            [window.layer renderInContext:context];
        }
    }
    
    //    //    ////////////////////////
    if ([screenWindow respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [screenWindow drawViewHierarchyInRect:screenWindow.bounds afterScreenUpdates:YES];
    } else {
        [screenWindow.layer renderInContext:context];
    }
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    screenWindow.layer.contents = nil;
    UIGraphicsEndImageContext();
    
    float iOSVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if(iOSVersion < 8.0)
    {
        image = [self rotateUIInterfaceOrientationImage:image];
    }
    return image;
}

+ (UIImage *)rotateUIInterfaceOrientationImage:(UIImage *)image{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationLandscapeRight:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationRight];
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationDown];
        }
            break;
        case UIInterfaceOrientationPortrait:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationUp];
        }
            break;
        case UIInterfaceOrientationUnknown:
        {
        }
            break;
            
        default:
            break;
    }
    
    return image;
}

//截取view中某个区域生成一张图片
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);//下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return image;
}

//截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)captureScrollView:(UIScrollView *)scrollView
{
    CGRect frame = scrollView.frame;
    
    //设置控件显示的区域大小     key:显示
    scrollView.frame = CGRectMake(0, scrollView.frame.origin.y, scrollView.contentSize.width, scrollView.contentSize.height);
    
    //设置截屏大小(截屏区域的大小必须要跟视图控件的大小一样)
    UIGraphicsBeginImageContextWithOptions(scrollView.frame.size, YES, 0.0);
    [[scrollView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    scrollView.frame = frame;
    return viewImage;
}

+ (UIImage *)compressImageData:(NSData *)imageData
{
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    if (![self isNeedCompress:imageData]) {
        return image;
    }
    NSInteger compressRate = 0;
    if ([self isPortait:image]) {
        compressRate = [self computeSampleSize:image minSideLength:750 maxNumOfPixels:1334 * 750];  // 安卓:1240 * 860
    }else{
        compressRate = [self computeSampleSize:image minSideLength:750 maxNumOfPixels:750 * 1334];
    }
    
    NSInteger width = image.size.width / compressRate;
    return [self compressImage:image targetWidth:width];
}

+ (UIImage *)compressImage:(UIImage *)image width:(NSInteger)minWidth minHeight:(NSInteger)minHeight
{
    if (![image isKindOfClass:[UIImage class]]) {
        return nil;
    }
    if (image.size.width < WIDTHFC) {
        return image;
    }
    NSInteger compressRate = 0;
    if ([self isPortait:image]) {
        compressRate = [self computeSampleSize:image minSideLength:minWidth maxNumOfPixels:minWidth * minHeight];  // 安卓:1240 * 860
    }else{
        compressRate = [self computeSampleSize:image minSideLength:minWidth maxNumOfPixels:minWidth * minHeight];
    }
    NSInteger width = image.size.width / compressRate;
    return [self compressImage:image targetWidth:width];
}


+ (UIImage *)compressImage:(UIImage *)image
{
    if (![image isKindOfClass:[UIImage class]]) {
        return nil;
    }
    if (image.size.width < WIDTHFC) {
        return image;
    }
    NSInteger compressRate = 0;
    if ([self isPortait:image]) {
        compressRate = [self computeSampleSize:image minSideLength:640 maxNumOfPixels:1136 * 640];  // 安卓:1240 * 860
    }else{
        compressRate = [self computeSampleSize:image minSideLength:640 maxNumOfPixels:1136 * 640];
    }
    NSInteger width = image.size.width / compressRate;
    return [self compressImage:image targetWidth:width];
}

+ (UIImage *)compressImage:(UIImage *)image width:(NSInteger)width
{
    if (![image isKindOfClass:[UIImage class]]) {
        return nil;
    }
    if (image.size.width < WIDTHFC) {
        return image;
    }
    NSInteger compressRate = 0;
    if ([self isPortait:image]) {
        compressRate = [self computeSampleSize:image minSideLength:width maxNumOfPixels:width * 1.775 * width];  // 安卓:1240 * 860
    }else{
        compressRate = [self computeSampleSize:image minSideLength:width maxNumOfPixels:width * width * 1.775];
    }
    
    NSInteger targetWidth = image.size.width / compressRate;
    return [self compressImage:image targetWidth:targetWidth];
}

+ (UIImage*)imageForUIView:(UIView*)view
{
    //    UIGraphicsBeginImageContext(view.bounds.size);// 只会生成屏幕所见的部分
    CGSize size = view.bounds.size;
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *sView = (UIScrollView *)view;
        size = CGSizeMake(sView.frame.size.width,sView.contentSize.height+ sView.contentInset.top+ sView.contentInset.bottom);
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, view.layer.contentsScale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    //    CGContextRestoreGState(currnetContext);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (NSInteger)computeSampleSize:(UIImage *)image minSideLength:(NSInteger)minSideLength maxNumOfPixels:(NSInteger)maxNumOfPixels
{
    NSInteger initialSize = [self computeInitialSampleSize:image minSideLength:minSideLength maxNumOfPixels:maxNumOfPixels];
    NSInteger roundedSize = 0;
    if (initialSize <= 8) {
        roundedSize = 1;
        while (roundedSize < initialSize) {
            roundedSize <<= 1;
        }
    }else{
        roundedSize = (initialSize + 7) / 8 * 8;
    }
    return roundedSize;
}

+ (NSInteger)computeInitialSampleSize:(UIImage *)image minSideLength:(NSInteger)minSideLength maxNumOfPixels:(NSInteger)maxNumOfPixels
{
    double w = image.size.width;
    double h = image.size.height;
    
    NSInteger lowerBound = (maxNumOfPixels == -1) ? 1 : (int)ceil(sqrt(w * h / maxNumOfPixels));
    NSInteger upperBound = (minSideLength == -1) ? 128 : (int) MIN(floor(w / minSideLength), floor(h / minSideLength));
    if (upperBound < lowerBound) {
        return lowerBound;
    }
    if ((maxNumOfPixels == -1) && (minSideLength == -1)) {
        return 1;
    }else if (minSideLength == -1) {
        return lowerBound;
    } else {
        return upperBound;
    }
}

+ (BOOL)isNeedCompress:(NSData *)imageData
{
    return imageData.length > 500 * 1024;
}

+ (BOOL)isPortait:(UIImage *)image
{
    return image.size.height >= image.size.width;
}

+ (NSString *)KMGUnit:(NSInteger)size
{
    if (size >= (1024 * 1024 * 1024)) {
        return [[NSString alloc] initWithFormat:@"%.2f G",size / (1024 * 1024 * 1024.0f)];
    }else if (size >= (1024 * 1024)){
        return [[NSString alloc] initWithFormat:@"%.2f M",size / (1024 * 1024.0f)];
    }else{
        return [[NSString alloc] initWithFormat:@"%.2f K",size / 1024.0f];
    }
}

+ (NSTimeInterval)mmSecondsSince1970
{
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSInteger)secondsSince1970
{
    return (NSInteger)[[NSDate date] timeIntervalSince1970];
}

+ (NSTimeInterval)chinaSecondsSince1970
{
    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
    return seconds + 8 * 3600;
}

+ (NSInteger)weekdayStringFromDate:(NSDate*)inputDate
{
    NSArray *weekdays = [NSArray arrayWithObjects: @(0), @(7), @(1), @(2), @(3), @(4), @(5), @(6), nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [[weekdays objectAtIndex:theComponents.weekday] integerValue];
}

+ (NSDateComponents *)yearMonthDayFromDate:(NSDate *)date
{
    if (date == nil) {
        return nil;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit year = NSCalendarUnitYear;
    NSCalendarUnit month = NSCalendarUnitMonth;
    NSCalendarUnit day = NSCalendarUnitDay;
    NSCalendarUnit hour = NSCalendarUnitHour;
    NSCalendarUnit minute = NSCalendarUnitMinute;
    NSCalendarUnit second = NSCalendarUnitSecond;
    NSCalendarUnit weekday = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:year|month|day|hour|minute|second|weekday fromDate:date];
    return theComponents;
    //    return @[@(theComponents.year),@(theComponents.month),@(theComponents.day),@(theComponents.hour),@(theComponents.minute),@(theComponents.second),@(theComponents.weekday)];
}

+ (NSString *)iPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSDateComponents *)chineseDate:(NSDate *)date
{
    if (![date isKindOfClass:[NSDate class]]) {
        return nil;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return components;
}

+ (NSArray<NSString *> *)chineseCalendarForDate:(NSDate *)date
{
    if (![date isKindOfClass:[NSDate class]]) {
        return nil;
    }
    NSDateComponents *components = [self chineseDate:date];
    return @[[self chineseCalendarYear:components.year - 1],[self chineseCalendarMonth:components.month - 1],[self chineseCalendarDay:components.day - 1]];
}

+ (NSString *)chineseCalendarYear:(NSInteger)index
{
    NSArray *chineseYears = @[@"甲子",  @"乙丑",  @"丙寅",  @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                              @"甲戌",   @"乙亥",  @"丙子",  @"丁丑",  @"戊寅",  @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                              @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                              @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                              @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                              @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥"];
    return chineseYears[index % chineseYears.count];
}

+ (NSString *)chineseCalendarMonth:(NSInteger)index
{
    NSArray *chineseYears = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"];
    return chineseYears[index % chineseYears.count];
}

+ (NSString *)chineseCalendarDay:(NSInteger)index
{
    NSArray *chineseYears = @[  @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                                @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                                @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    return chineseYears[index % chineseYears.count];
}

+ (NSArray *)arrayFromArray:(NSArray *)array withString:(NSString *)string
{
    if (array == nil || string == nil) {
        return nil;
    }
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:string];
    for (int x = 0; x < str.length; x ++) {
        [retArray addObject:[str substringWithRange:NSMakeRange(x, 1)]];
    }
    
    for (int x = 0; x < retArray.count; x ++) {
        for (int y = 0; y < array.count; y ++) {
            NSRange range = [array[y] rangeOfString:retArray[x]];
            if (range.location != NSNotFound) {
                if (![result containsObject:array[y]]) {
                    [result addObject:array[y]];
                }
            }
        }
    }
    return result;
}

+ (NSArray *)arrayFromJsonstring:(NSString *)string
{
    NSData *data = [self dataFromString:string];
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return result;
}

+ (NSArray *)arrayReverseWithArray:(NSArray *)array
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSInteger x = array.count - 1; x >= 0; x --) {
        [temp addObject:array[x]];
    }
    return temp;
}

+ (NSString *)randomNumberWithDigit:(int)digit
{
    NSUInteger value = arc4random();
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"%lu",(unsigned long)value];
    NSMutableString *strLst;
    if (string.length >= digit) {
        strLst = (NSMutableString *)[string substringFromIndex:string.length - digit];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int x = 0; x < digit - string.length; x ++) {
            NSInteger count = arc4random();
            int last = count % 10;
            NSString *str = [[NSString alloc] initWithFormat:@"%d",last];
            [array addObject:str];
        }
        [array addObject:string];
        strLst = (NSMutableString *)[array componentsJoinedByString:@""];
    }
    return strLst;
}

+ (BOOL)isPureInt:(NSString *)string
{
    if (string.length == 0) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string
{
    if ((string.length == 0)) {
        return NO;
    }
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isLeapYear:(int)year
{
    if ((year % 4  == 0 && year % 100 != 0)  || year % 400 == 0)
        return YES;
    else
        return NO;
}

+ (NSArray *)arrayByOneCharFromString:(NSString *)string
{
    if (string.length == 0) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int x = 0; x < string.length; x ++) {
        [array addObject:[string substringWithRange:NSMakeRange(x, 1)]];
    }
    return array;
}

+ (NSString *)blankInChars:(NSString *)string byCellNo:(int)num
{
    if (string.length == 0) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int x = 0; x < string.length; x ++) {
        [array addObject:[string substringWithRange:NSMakeRange(x, 1)]];
    }
    
    NSMutableArray *last = [[NSMutableArray alloc] init];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < array.count;  x++) {
        
        [temp addObject:array[x]];
        if (temp.count == num ) {
            [last addObject:temp];
            temp = [[NSMutableArray alloc] init];
        }
        
        if ((temp.count + last.count * num) == array.count) {
            [last addObject:temp];
        }
    }
    
    NSMutableArray *finish = [[NSMutableArray alloc] init];
    for (int x = 0; x < last.count; x ++) {
        [last[x] addObject:@" "];
        NSMutableArray *tempArr = last[x];
        for (int y = 0; y < tempArr.count; y ++) {
            [finish addObject:tempArr[y]];
        }
    }
    NSString *lastString = [finish componentsJoinedByString:@""];
    return lastString;
}

+ (NSString *)jsonStringWithObject:(id)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        NSError *error;
        //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

+ (NSString *)JSONString:(NSString *)aString
{
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

+ (id)objectFromJSonstring:(NSString *)jsonString;
{
    if (jsonString.length == 0) {
        return nil;
    }
    
    NSError *error;
    //    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    id dataClass = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return dataClass;
}

+ (void)popToController:(NSString *)className navigationController:(UINavigationController *)navigationController animated:(BOOL)animated
{
    for (int x = 0; x < navigationController.viewControllers.count; x ++) {
        UIViewController *controller = navigationController.viewControllers[x];
        if ([controller isKindOfClass:NSClassFromString(className)]) {
            [navigationController popToViewController:controller animated:animated];
            return;
        }
    }
}

+ (NSData *)dataFromString:(NSString *)string
{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)dataToString:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}

+ (NSString *)dataToString:(NSData *)data withEncoding:(NSStringEncoding)encode
{
    return [[NSString alloc] initWithData:data
                                 encoding:encode];
}

+ (NSString *)homeDirectoryPath:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (NSString *)documentsPath:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (NSString *)temporaryDirectoryFile:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *filePath = [tmpDirectory stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (BOOL)keyedArchiverWithArray:(NSArray *)array toFilePath:(NSString *)fileName
{
    if (array.count == 0 || fileName.length == 0) {
        return NO;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    if (success) {
        return YES;
    }
    return NO;
}

+ (NSArray *)keyedUnarchiverWithArray:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (BOOL)keyedArchiverWithData:(NSData *)data toFilePath:(NSString *)fileName
{
    if (data.length == 0 || fileName.length == 0) {
        return NO;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL success = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    if (success) {
        return YES;
    }
    return NO;
}

+ (NSData *)keyedUnarchiverWithData:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath ];
}

+ (NSData*)rsaEncryptString:(SecKeyRef)key data:(NSString*) data
{
    if (key == nil) {
        return nil;
    }
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    NSData *stringBytes = [data dataUsingEncoding:NSUTF8StringEncoding];
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init];
    for (int i=0; i<blockCount; i++) {
        int bufferSize = (int)MIN(blockSize,[stringBytes length] - i * blockSize);
        NSData *buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes],
                                        [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }else{
            if (cipherBuffer)
                free(cipherBuffer);
            return nil;
        }
    }
    if (cipherBuffer)
        free(cipherBuffer);
    return encryptedData;
}

//压缩图片到指定文件大小
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length/1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+ (BOOL)keyedArchiverWithNumber:(NSNumber *)number toFilePath:(NSString *)fileName
{
    if (number == nil || fileName.length == 0) {
        return NO;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL success = [NSKeyedArchiver archiveRootObject:number toFile:filePath];
    if (success) {
        return YES;
    }
    return NO;
}

+ (NSNumber *)keyedUnarchiverWithNumber:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath ];
}

+ (BOOL)keyedArchiverWithString:(NSString *)string toFilePath:(NSString *)fileName
{
    if (string.length == 0 || fileName.length == 0) {
        return NO;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL success = [NSKeyedArchiver archiveRootObject:string toFile:filePath];
    if (success) {
        return YES;
    }
    return NO;
}

+ (NSString *)keyedUnarchiverWithString:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath ];
}

+ (BOOL)keyedArchiverWithDictionary:(NSDictionary *)dic toFilePath:(NSString *)fileName
{
    if (dic.count == 0 || fileName.length == 0) {
        return NO;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL success = [NSKeyedArchiver archiveRootObject:dic toFile:filePath];
    if (success) {
        return YES;
    }
    return NO;
}

+ (NSDictionary *)keyedUnarchiverWithDictionary:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath ];
}

+ (BOOL)createFile:(NSString *)fileName withContent:(NSString *)string
{
    if (fileName.length == 0 || string.length == 0) {
        return NO;
    }
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [arrayPath lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [fileManager createFileAtPath:filePath contents:data attributes:nil];
}

+ (BOOL)moveFile:(NSString *)filePath toPath:(NSString *)newPath
{
    if (filePath.length == 0 || newPath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager moveItemAtPath:filePath toPath:newPath error:nil];
}

+ (BOOL)renameFile:(NSString *)filePath toPath:(NSString *)newPath
{
    if (filePath.length == 0 || newPath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager moveItemAtPath:filePath toPath:newPath error:nil];
}

+ (BOOL)copyFile:(NSString *)filePath toPath:(NSString *)newPath
{
    if (filePath.length == 0 || newPath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL success = [fileManager copyItemAtPath:filePath toPath:newPath error:&error];
    return success;
}

+ (BOOL)removeFile:(NSString *)filePath
{
    if (filePath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) {
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

+ (BOOL)isChinese:(NSString *)string
{
    NSString *chinese = @"^[\\u4E00-\\u9FA5\\uF900-\\uFA2D]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chinese];
    return [phoneTest evaluateWithObject:string];
}

+ (BOOL)isValidateEmail : (NSString *) email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)isValidateUserPasswd :(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[a-zA-Z0-9]{6,16}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isChar:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[a-zA-Z]*$"    //^[0-9]*$
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isNumber:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[0-9]*$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isDateAEarlierThanDateB:(NSDate *)aDate bDate:(NSDate *)bDate
{
    NSTimeInterval aTime = [aDate timeIntervalSince1970];
    NSTimeInterval bTime = [bDate timeIntervalSince1970];
    if (aTime < bTime) {
        return YES;
    }
    return NO;
}

+ (BOOL)isString:(NSString *)aString containString:(NSString *)bString
{
    for (int x = 0; x < aString.length; x ++) {
        NSRange range = NSMakeRange(x,1);
        NSString *subString = [aString substringWithRange:range];
        if ([subString isEqualToString:bString]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isStringContainsStringAndNumber:(NSString *)sourceString
{
    if ([sourceString isKindOfClass:[NSString class]]) {
        if (sourceString.length == 0) {
            return NO;
        }
        BOOL containsNumber = NO;
        BOOL containsChar = NO;
        for (int x = 0; x < sourceString.length; x ++) {
            NSString *componentString = [sourceString substringWithRange:NSMakeRange(x, 1)];
            if ([self isPureInt:componentString]) {
                containsNumber = YES;
            }else{
                containsChar = YES;
            }
        }
        return containsChar&&containsNumber;
    }else{
        return NO;
    }
    return NO;
}

+ (int)isTheSameDayA:(NSDate *)aDate b:(NSDate *)bDate
{
    // 是返回1 不是返回2 其他返回0
    if (aDate == nil  || bDate == nil) {
        return 0;
    }
    NSCalendar *calendarA = [NSCalendar currentCalendar];
    NSDateComponents *componentsA = [calendarA components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:aDate];
    NSInteger yearA = [componentsA year];
    NSInteger monthA = [componentsA month];
    NSInteger dayA = [componentsA day];
    
    NSCalendar *calendarB = [NSCalendar currentCalendar];
    NSDateComponents *componentsB = [calendarB components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:bDate];
    NSInteger yearB = [componentsB year];
    NSInteger monthB = [componentsB month];
    NSInteger dayB = [componentsB day];
    
    if ((yearA == yearB) && (monthA == monthB) && (dayA == dayB)) {
        return 1;
    }
    return 2;
}

+ (BOOL)isDateA:(NSDate *)aDate earlierToB:(NSDate *)bDate
{
    if (aDate == nil  || bDate == nil) {
        return NO;
    }
    
    NSTimeInterval aTimeInterval = [aDate timeIntervalSince1970];
    NSTimeInterval bTimeInterval = [bDate timeIntervalSince1970];
    if (aTimeInterval < bTimeInterval) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkTextFieldHasValidInput:(UITextField *)textField
{
    NSString *text = [self cleanString:textField.text];
    return text.length;
}

+ (BOOL)isURLString:(NSString *)sourceString
{
    NSString *matchString = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matchString];
    return [phoneTest evaluateWithObject:sourceString];
}

+ (BOOL)isHaveChineseInString:(NSString *)string
{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isAllNum:(NSString *)string
{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)networkSettedProxy
{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    //    NSLog(@"\n%@",proxies);
    NSDictionary *settings = proxies[0];
    //    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    //    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    //    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
    return ![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"];
}

+ (BOOL)isValidateString:(NSString *)string
{
    return [string isKindOfClass:[NSString class]] && string.length;
}

+ (BOOL)isValidateArray:(NSArray *)array
{
    return [array isKindOfClass:[NSArray class]] && array.count;
}

+ (BOOL)isValidateDictionary:(NSDictionary *)dictionary
{
    return [dictionary isKindOfClass:[NSDictionary class]] && dictionary.count;
}

+ (BOOL)floatEqual:(float)aNumber bNumber:(float)bNumber
{
    NSNumber *a=[NSNumber numberWithFloat:aNumber];
    NSNumber *b=[NSNumber numberWithFloat:bNumber];
    return [a compare:b] == NSOrderedSame;
}

+ (CGFloat)absoluteValue:(CGFloat)value
{
    if (value < 0.00001) {
        return -value;
    }
    return value;
}

+ (CGFloat)taxForSalaryAfterSocialSecurity:(CGFloat)money
{
    CGFloat deltaMoney = money - 3500;
    if (deltaMoney <= 0) {
        return 0;
    }
    NSArray *rateArray = [self taxRateForMoney:deltaMoney];
    CGFloat taxRate = [rateArray[0] floatValue];
    CGFloat quickNumber = [rateArray[1] floatValue];
    return deltaMoney * taxRate - quickNumber;
}

+ (NSArray *)taxRatesWithMoneyAfterTax:(CGFloat)money
{
    NSArray *rateArray = @[
                           @[@0.03,@0,@0,@1500],
                           @[@0.1,@105,@1500,@4500],
                           @[@.2,@555,@4500,@9000],
                           @[@.25,@1005,@9000,@35000],
                           @[@.3,@2755,@35000,@55000],
                           @[@.35,@5505,@55000,@80000],
                           @[@.45,@13505,@8000000]
                           ];
    NSMutableArray *selectArrays = [[NSMutableArray alloc] init];
    for (int x = 0; x < rateArray.count; x ++) {
        if (x == (rateArray.count - 1)) {
            NSArray *subRateArray = rateArray[x];
            CGFloat marginMin = [subRateArray[2] floatValue];
            CGFloat quickNumber = [subRateArray[1] floatValue];
            CGFloat taxRate = [subRateArray[0] floatValue];
            CGFloat salary = (money - quickNumber - 3500 * taxRate) / (1 - taxRate);
            if ((salary - 3500) > marginMin) {
                [selectArrays addObject:subRateArray];
            }
        }else{
            NSArray *subRateArray = rateArray[x];
            CGFloat marginMin = [subRateArray[2] floatValue];
            CGFloat marginMax = [subRateArray[3] floatValue];
            CGFloat quickNumber = [subRateArray[1] floatValue];
            CGFloat taxRate = [subRateArray[0] floatValue];
            CGFloat salary = (money - quickNumber - 3500 * taxRate) / (1 - taxRate);
            if (((salary - 3500) > marginMin) && ((salary - 3500) <= marginMax)) {
                [selectArrays addObject:subRateArray];
            }
        }
    }
    if (!selectArrays.count) {
        return nil;
    }
    return selectArrays;
}

+ (NSArray *)taxRateForMoney:(CGFloat)money
{
    if (money <= 1500) {
        return @[@0.03,@0];
    }else if (money <= 4500){
        return @[@0.1,@105];
    }else if (money <= 9000){
        return @[@.2,@555];
    }else if (money <= 35000){
        return @[@.25,@1005];
    }else if (money <= 55000){
        return @[@.3,@2755];
    }else if (money <= 80000){
        return @[@.35,@5505];
    }else
        return @[@.45,@13505];
}

//+ (NetStatus)netWorkStatus
//{
//    Reachability *reach = [Reachability reachabilityWithHostName:URL_NETWORKSTATUS_FUDATA];
//    int flag = reach.currentReachabilityStatus;
//    return flag;
//}

+ (NSNumber *)fileSize:(NSString *)filePath
{
    if (filePath.length == 0) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attrDic = [fileManager attributesOfItemAtPath:filePath error:nil];
    NSNumber *fileSize = [attrDic objectForKey:NSFileSize];
    return fileSize;
}

+ (NSValue *)rangeValue:(NSRange)range
{
    return [NSValue valueWithRange:range];
}

+ (NSString *)localFilePath:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (NSString *)md5:(NSString *)str
{
    if (str.length == 0) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];//16
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result);
    return [NSString  stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12],
            result[13], result[14], result[15]
            ];
}

+ (NSString *)stringDeleteNewLineAndWhiteSpace:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)adID
{
    //    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return nil;
}

+ (NSString *)pathForResource:(NSString *)name type:(NSString *)type
{
    return [[NSBundle mainBundle] pathForResource:name ofType:type];
}

//+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey
//{
//    const void *vplainText;
//    size_t plainTextBufferSize;
//
//    if (encryptOrDecrypt == kCCDecrypt)//解密
//    {
//        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
//        plainTextBufferSize = [EncryptData length];
//        vplainText = [EncryptData bytes];
//    }else //加密
//    {
//        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//        plainTextBufferSize = [data length];
//        vplainText = (const void *)[data bytes];
//    }
//
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
//
//    const void *vkey = (const void *)[encryptOrDecryptKey UTF8String];
//    // NSString *initVec = @"init Vec";
//    //const void *vinitVec = (const void *) [initVec UTF8String];
//    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
//    ccStatus = CCCrypt(encryptOrDecrypt,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding | kCCOptionECBMode,
//                       vkey,
//                       kCCKeySize3DES,
//                       nil,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//        if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
//        else if (ccStatus == kCCParamError) return @"PARAM ERROR";
//        else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
//        else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
//        else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
//        else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
//        else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
//
//    NSString *result;
//
//    if (encryptOrDecrypt == kCCDecrypt)
//    {
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
//                                                                length:(NSUInteger)movedBytes]
//                                        encoding:NSUTF8StringEncoding];
//    }else{
//        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//        result = [GTMBase64 stringByEncodingData:myData];
//    }
//
//    free(bufferPtr);
//    return result;
//}

+ (NSString *)timeStamp
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
    NSString* str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)identifierForVendorFromKeyChain
{
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString * const KEY_USERNAME_PASSWORD = @"com.junnet.HyPhonePass";
    NSString * const KEY_PASSWORD = @"com.junnet.HyPhonePass";
    
    NSMutableDictionary *readUserPwd = (NSMutableDictionary *)[self load:KEY_USERNAME_PASSWORD];
    if (!readUserPwd) {
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:identifierStr forKey:KEY_PASSWORD];
        [self save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
        return identifierStr;
    }else{
        return [readUserPwd objectForKey:KEY_PASSWORD];
    }
}

+ (NSString *)asciiCodeWithString:(NSString *)string
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int x = 0; x < string.length; x ++) {
        NSString *aStr = [string substringWithRange:NSMakeRange(x, 1)];
        [str appendFormat:@"%d",[aStr characterAtIndex:0]];
    }
    return str;
}

+ (NSString *)stringFromASCIIString:(NSString *)string
{
    unsigned short asciiCode = [string intValue];
    return [[NSString alloc] initWithFormat:@"%C",asciiCode];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

//取
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

+ (NSString*)generate3DesKey:(NSString*)seed timestamp:(NSString*)timestamp
{
    NSString * keyStr = [NSString stringWithFormat:@"%@_%d_%@",
                         seed, rand(), timestamp];      // 这个值会是固定的吗?
    NSString * key = [self md5:keyStr];
    key = [key substringToIndex:24];
    return key;
}

+ (NSString *)encryptKye
{
    return @"345243523653445765874";
}

//+ (NSString*)getRsaEncryptParams:(SecKeyRef)publicKey params:(NSString*)params timestamp:(NSString*)timestamp
//{
//    NSString* key = [self generate3DesKey:[self encryptKye] timestamp:timestamp];
//    NSString* encryptParams3des = [self tripleDES:params encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:key];
//
//    NSData* keyEncryptData = [self rsaEncryptString:publicKey data:key];
//    NSString* keyEncryptStr = [self DataToHex:keyEncryptData];
//    if(keyEncryptStr == nil || keyEncryptStr.length == 0){
//        return nil;
//    }
//    NSString* encryptParams = [NSString stringWithFormat:@"Z%@z%@", keyEncryptStr, encryptParams3des];
//    return encryptParams;
//}

+ (NSString *)DataToHex:(NSData *)data {
    
    Byte *bytes = (Byte *)[data bytes];
    NSMutableDictionary  *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:@"" forKey:@"value"];
    
    for(int i=0;i<[data length];i++)
    {
        NSString *hexStr = @"";
        NSString *newHexStr = [[NSString alloc] initWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length] == 1)
        {
            hexStr = [[NSString alloc] initWithFormat:@"%@0%@",[temp objectForKey:@"value"],newHexStr];
            [temp setObject:hexStr forKey:@"value"];
            //            [hexStr release];    //  注释被保留的原因是在非ARC模式下，会内存泄漏；如果alloc时采用autorelese，数据量大时会导致崩溃
        }else{
            hexStr = [[NSString alloc] initWithFormat:@"%@%@",[temp objectForKey:@"value"],newHexStr];
            [temp setObject:hexStr forKey:@"value"];
            //            [hexStr release];
        }
        //        [newHexStr release];
    }
    //JLog(@"bytes 的16进制数为:%@",hexStr);
    return [temp objectForKey:@"value"];
}

+ (NSString *)cleanString:(NSString *)str
{
    if (str == nil) {
        return @"";
    }
    NSMutableString *cleanString = [NSMutableString stringWithString:str];
    [cleanString replaceOccurrencesOfString:@"\n" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@"\r" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@" " withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    return cleanString;
}

+ (NSString *)placeholderString:(NSString *)string font:(NSInteger)font back:(NSInteger)back
{
    if (string.length == 0) {
        return nil;
    }
    
    if (string.length >= 6) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int x = 0; x < string.length; x ++) {
            [array addObject:[string substringWithRange:NSMakeRange(x, 1)]];
        }
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        
        for (int x = 0; x < string.length; x ++) {
            
            if (x < font || x >= string.length - back) {
                [temp addObject:array[x]];
            }else{
                [temp addObject:@"*"];
            }
        }
        return [temp componentsJoinedByString:@""];
    }
    return nil;
}

+ (NSString *)stringByDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString *string = [[NSString alloc] initWithFormat:@"%@",localeDate];
    return string;
}

+ (NSString *)bankStyleDataThree:(id)data
{
    if (!data) {
        return @"0.00";
    }
    
    NSString *str = [[NSString alloc] initWithFormat:@"%@",data];
    if (str.length == 0) {
        return @"0.00";
    }
    
    if ([data isKindOfClass:[NSNull class]]) {
        return @"0.00";
    }
    
    if ([data isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];    // 100,000.00
        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[data doubleValue]]];
        return formattedNumberString;
    }else if([data isKindOfClass:[NSString class]]){
        if ([self isPureFloat:data] || [self isPureInt:data]) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@"###,##0.00;"];    // 100,000.00
            NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[data doubleValue]]];
            return formattedNumberString;
        }else{
            return [[NSString alloc] initWithFormat:@"%@",data];
        }
    }else{
        return [[NSString alloc] initWithFormat:@"%@",data];
    }
}

+ (NSString *)bankStyleData:(id)data
{
    if (!data) {
        return @"0.00";
    }
    
    NSString *str = [[NSString alloc] initWithFormat:@"%@",data];
    if (str.length == 0) {
        return @"0.00";
    }
    
    if ([data isKindOfClass:[NSNull class]]) {
        return @"0.00";
    }
    
    if ([data isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        //        [numberFormatter setPositiveFormat:@"###,##0.00;"];    // 100,000.00
        [numberFormatter setPositiveFormat:@"0.00;"];
        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[data doubleValue]]];
        return formattedNumberString;
    }else if([data isKindOfClass:[NSString class]]){
        if ([self isPureFloat:data] || [self isPureInt:data]) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@"0.00;"];
            NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[data doubleValue]]];
            return formattedNumberString;
        }else{
            return [[NSString alloc] initWithFormat:@"%@",data];
        }
    }else{
        return [[NSString alloc] initWithFormat:@"%@",data];
    }
}

+ (NSString *)zeroHandle:(id)data
{
    if (!data) {
        return @"";
    }
    
    NSString *str = [[NSString alloc] initWithFormat:@"%@",data];
    if (str.length == 0) {
        return @"";
    }
    
    if ([data isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if ([data isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        //        [numberFormatter setPositiveFormat:@"###,##0.00;"];    // 100,000.00
        [numberFormatter setPositiveFormat:@"0.00;"];
        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[data doubleValue]]];
        return formattedNumberString;
    }else if([data isKindOfClass:[NSString class]]){
        if ([data floatValue] == 0) {
            return @"";
        }
        
        if ([self isPureFloat:data] || [self isPureInt:data]) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@"0.00;"];
            NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[data doubleValue]]];
            return formattedNumberString;
        }else{
            return [[NSString alloc] initWithFormat:@"%@",data];
        }
    }else{
        return [[NSString alloc] initWithFormat:@"%@",data];
    }
}

+ (NSString *)fourNoFiveYes:(float)number afterPoint:(int)position  // 只入不舍
{
    NSDecimalNumberHandler  *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (double)forwardValue:(double)number afterPoint:(int)position  // 只入不舍
{
    NSNumber *classNumber = [NSNumber numberWithDouble:number];
    NSString *classString = [classNumber stringValue];
    
    NSArray *valueArray = [classString componentsSeparatedByString:@"."];
    if (valueArray.count == 2) {
        NSString *pointString = valueArray[1];
        if (pointString.length <= position) {
            return number;
        }
    }
    
    NSDecimalNumberHandler  *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces doubleValue];
}

+ (NSString *)newFloat:(float)value withNumber:(int)numberOfPlace
{
    NSString *formatStr = @"%0.";
    formatStr = [formatStr stringByAppendingFormat:@"%df", numberOfPlace];
    formatStr = [NSString stringWithFormat:formatStr, value];
    return formatStr;
}

+ (NSString *)backBankData:(NSString *)text
{
    if (text.length == 0) {
        return nil;
    }
    NSArray *array = [text componentsSeparatedByString:@"."];
    if (array.count >= 1) {
        NSString *string = array[0];
        string = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
        return string;
    }
    return nil;
}

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue  valueB:(NSString *)multiplicandValue
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
    return [product stringValue];
}

+ (NSString *)highAdd:(NSString *)aValue add:(NSString *)bValue
{
    NSDecimalNumber *addendNumber = [NSDecimalNumber decimalNumberWithString:aValue];
    NSDecimalNumber *augendNumber = [NSDecimalNumber decimalNumberWithString:bValue];
    NSDecimalNumber *sumNumber = [addendNumber decimalNumberByAdding:augendNumber];
    return [sumNumber stringValue];
}

+ (NSString *)highSubtract:(NSString *)fontValue add:(NSString *)backValue
{
    NSDecimalNumber *addendNumber = [NSDecimalNumber decimalNumberWithString:fontValue];
    NSDecimalNumber *augendNumber = [NSDecimalNumber decimalNumberWithString:backValue];
    NSDecimalNumber *sumNumber = [addendNumber decimalNumberBySubtracting:augendNumber];
    return [sumNumber stringValue];
}

+ (NSString *)highMultiply:(NSString *)aValue add:(NSString *)bValue
{
    NSDecimalNumber *addendNumber = [NSDecimalNumber decimalNumberWithString:aValue];
    NSDecimalNumber *augendNumber = [NSDecimalNumber decimalNumberWithString:bValue];
    NSDecimalNumber *sumNumber = [addendNumber decimalNumberByMultiplyingBy:augendNumber];
    return [sumNumber stringValue];
}

+ (NSString *)highDivide:(NSString *)aValue add:(NSString *)bValue
{
    NSDecimalNumber *addendNumber = [NSDecimalNumber decimalNumberWithString:aValue];
    NSDecimalNumber *augendNumber = [NSDecimalNumber decimalNumberWithString:bValue];
    NSDecimalNumber *sumNumber = [addendNumber decimalNumberByDividingBy:augendNumber];
    return [sumNumber stringValue];
}

+ (NSString *)placeholderStringFor:(NSString *)sourceString{
    if (sourceString.length == 0) {
        return @"-";
    }else{
        return sourceString;
    }
}

+ (NSString *)placeholderStringFor:(NSString *)sourceString with:(NSString *)placeholderString
{
    if ([sourceString isKindOfClass:[NSNull class]] || (sourceString == nil)) {
        return placeholderString;
    }
    sourceString = [[NSString alloc] initWithFormat:@"%@",sourceString];
    if (sourceString.length == 0) {
        return placeholderString;
    }
    return sourceString;
}

+ (NSString *)addStringWithSpace:(NSString *)aString bString:(NSString *)bString{
    if (aString.length == 0) {
        aString = @"-";
    }
    if (bString.length == 0) {
        bString = @"-";
    }
    return [[NSString alloc] initWithFormat:@"%@  %@",aString,bString];
}

+ (NSString *)base64StringForText:(NSString *)text
{
    if (text && [text isKindOfClass:NSString.class]) {
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }else{
        return nil;
    }
}

+ (NSString *)textFromBase64String:(NSString *)text
{
    if (text == nil) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)base64Code:(NSData *)data
{
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)sessionID:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSDictionary *dic = httpResponse.allHeaderFields;
    NSString *sessionid = [dic objectForKey:@"Set-Cookie"];
    NSString *subSession = @"";
    if (sessionid) {
        NSArray *array = [sessionid componentsSeparatedByString:@";"];
        NSString *session = array[0];
        subSession = [session componentsSeparatedByString:@"="][1];
    }
    return subSession;
}

+ (NSString *)hostNameFromUrlString:(NSString *)urlString
{
    if (urlString.length == 0) {
        return urlString;
    }
    NSArray *points = [urlString componentsSeparatedByString:@"."];
    if (points.count >= 2) {
        return points[1];
    }
    return nil;
}

+ (NSString *)ymdhsByTimeInterval:(NSTimeInterval)fTI
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:fTI];
    
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:localzone];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)ymdhsByTimeIntervalString:(NSString *)timeInterval
{
    return [self ymdhsByTimeInterval:[timeInterval doubleValue]];
}

+ (NSString *)countOverTime:(NSTimeInterval)time
{
    NSInteger seconds = time;
    NSMutableString *overdueTimeString = [[NSMutableString alloc] init];
    NSInteger day = seconds/(60*60*24);
    if (day > 0) {
        [overdueTimeString appendFormat:@"%ld天",(long)day];
    }
    NSInteger hour = (seconds - day*60*60*24)/3600;
    if (hour > 0) {
        [overdueTimeString appendFormat:@"%ld小时",(long)hour];
    }
    NSInteger minute = (seconds - day*60*60*24 - hour*3600)/60;
    if (minute > 0) {
        [overdueTimeString appendFormat:@"%ld分钟",(long)minute];
    }
    return overdueTimeString;
}

+ (NSString *)pinyinForHans:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}

+ (NSString *)convertNumbers:(NSString *)string
{
    if (![self isValidateString:string]) {
        return nil;
    }
    NSArray *numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSArray *array = @[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    NSMutableString *name = [[NSMutableString alloc] init];
    for (int x = 0; x < string.length; x ++) {
        NSString *sub = [string substringWithRange:NSMakeRange(x, 1)];
        if ([numbers containsObject:sub]) {
            NSInteger index = [numbers indexOfObject:sub];
            if ((index != NSNotFound) && array.count > index) {
                [name appendString:array[index]];
            }else{
                [name appendString:sub];
            }
        }
    }
    return [self pinyinForHansClear:name];
}

+ (NSString *)pinyinForHansClear:(NSString *)chinese        // 获取汉字的拼音，没有空格
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return [self cleanString:pinyin];
}

+ (NSString*)reverseWordsInString:(NSString*)str
{
    NSMutableString *reverString = [NSMutableString stringWithCapacity:str.length];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverString appendString:substring];
    }];
    return reverString;
}

+ (NSString *)twoChar:(NSInteger)value
{
    if (value < 10) {
        return [[NSString alloc] initWithFormat:@"0%@",@(value)];
    }
    return [[NSString alloc] initWithFormat:@"%@",@(value)];
}

+ (NSString *)scanQRCode:(UIImage *)image
{
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    NSString *result = nil;
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        result = feature.messageString;
        if ([result isKindOfClass:[NSString class]]) {
            break;
        }
    }
    return result;
}

+ (NSString *)dataToHex:(NSData *)data
{
    if (!data || [data length] == 0) {
        return nil;
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (NSString *)readableForTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *bDate = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:bDate];
}

+ (NSString *)stringWithDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter?:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

+ (NSAttributedString *)attributedStringFor:(NSString *)sourceString colorRange:(NSArray *)colorRanges color:(UIColor *)color textRange:(NSArray *)textRanges font:(UIFont *)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:sourceString];
    for (int x = 0; x < colorRanges.count; x ++) {
        NSValue *value = colorRanges[x];
        NSRange range;
        [value getValue:&range];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    for (int x = 0; x < textRanges.count; x ++) {
        NSValue *value = textRanges[x];
        NSRange range;
        [value getValue:&range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

+ (NSAttributedString *)attributedStringFor:(NSString *)sourceString strings:(NSArray *)colorStrings color:(UIColor *)color fontStrings:(NSArray * __nullable)fontStrings font:(UIFont * __nullable)font
{
    NSMutableArray *colorRangs = [[NSMutableArray alloc] initWithCapacity:colorStrings.count];
    NSMutableArray *textRangs = [[NSMutableArray alloc] initWithCapacity:fontStrings.count];
    for (NSString *colorStr in colorStrings) {
        NSRange range = [sourceString rangeOfString:colorStr];
        if (range.location != NSNotFound) {
            [colorRangs addObject:[NSValue valueWithRange:range]];
        }
    }
    for (NSString *fontStr in fontStrings) {
        NSRange range = [sourceString rangeOfString:fontStr];
        if (range.location != NSNotFound) {
            [textRangs addObject:[NSValue valueWithRange:range]];
        }
    }
    return [self attributedStringFor:sourceString colorRange:colorRangs color:color textRange:textRangs font:font];
}

- (NSAttributedString *)middleLineForLabel:(NSString *)text
{
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:text attributes:attribtDic];
    return attribtStr;
}

- (NSAttributedString *)underLineForLabel:(NSString *)text
{
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:text attributes:attribtDic];
    return attribtStr;
}


//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}

/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2
{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [self timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

+ (BOOL)isValidPassword:(NSString*)password
{
    BOOL valid = YES;
    if([password length] < 6 || [password length] > 30)
    {
        return NO;
    }
    
    for(int i=0; i<[password length]; i++)
    {
        unichar curChar = [password characterAtIndex:i];
        if(curChar >= '0' && curChar <= '9')
        {
            continue;
        }
        if(curChar >='a' && curChar <= 'z')
        {
            continue;
        }
        if(curChar >= 'A' && curChar <= 'Z')
        {
            continue;
        }
        valid = NO;
        break;
    }
    return valid;
}

+ (void)call:(NSString *)phone
{
    if (phone != nil) {
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)callPhoneWithNoNotice:(NSString *)phone
{
    if (phone == nil) {
        return;
    }
    NSString *str=[[NSString alloc] initWithFormat:@"tel:%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

//+ (void)gotoDownloadApp:(NSString *)appid
//{
//    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@",appid];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//}

+ (NSString *)deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air_5_wifi";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air_5_cell";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air_5_cell";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad mini_wifi";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad mini_cell";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air2";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    return deviceString;
}

+ (NSString *)easySeeTimesBySeconds:(NSInteger)timeInterVal
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterVal];
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    NSInteger year = dateComponents.year - 1970;
    NSInteger month = dateComponents.month - 1;
    NSInteger day = dateComponents.day - 1;
    NSInteger hour = dateComponents.hour - 8;
    NSInteger minute = dateComponents.minute;
    NSInteger second = dateComponents.second;
    if (hour < 0) {
        hour += 24;
        day --;
    }
    NSMutableString *valueString = [[NSMutableString alloc] init];
    if (year > 0) {
        [valueString appendString:[[NSString alloc] initWithFormat:@"%@年",@(year)]];
    }
    if (month > 0) {
        [valueString appendString:[[NSString alloc] initWithFormat:@"%@月",@(month)]];
    }
    if (day > 0) {
        [valueString appendString:[[NSString alloc] initWithFormat:@"%@天",@(day)]];
    }
    [valueString appendString:[[NSString alloc] initWithFormat:@"%@时",@(hour)]];
    [valueString appendString:[[NSString alloc] initWithFormat:@"%@分",@(minute)]];
    [valueString appendString:[[NSString alloc] initWithFormat:@"%@秒",@(second)]];
    return valueString;
}

//+ (NSString *)base64Code:(NSData *)data
//{
//    return [GTMBase64 stringByEncodingData:data];
//}

+ (NSString *)tenThousandNumber:(double)value
{
    if (value <= 100000) {
        return [[NSString alloc] initWithFormat:@"%.2f",value];
    }
    
    return [[NSString alloc] initWithFormat:@"%.2f万",value / 10000];
}

+ (NSString *)tenThousandNumberString:(NSString *)value
{
    double number = [value doubleValue];
    if (number <= 100000) {
        return value;
    }
    return [[NSString alloc] initWithFormat:@"%.2f万",number / 10000];
}

+ (NSString *)urlEncodedString:(NSString *)urlString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlString,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
}

+ (NSString *)urlDecodedString:(NSString *)urlString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)urlString,CFSTR(""),kCFStringEncodingUTF8));
}

+ (NSString *)replaceString:(NSMutableString *)string byString:(NSString *)replaceString
{
    // 必须是NSMutableString
    if (replaceString.length == 0) {
        replaceString = @"";
    }
    [string replaceOccurrencesOfString:@"\n" withString:replaceString options:NSCaseInsensitiveSearch range:NSMakeRange(0, [string length])];
    return string;
}

+ (void)openAppByURLString:(NSString *)str
{
    NSString *string = [NSString stringWithFormat:@"%@://://",str];
    NSURL *myURL_APP_A = [NSURL URLWithString:string];
    if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        [[UIApplication sharedApplication] openURL:myURL_APP_A];
    }
}

+ (void)flashLampShow:(BOOL)show
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {//判断是否有闪光灯
        if (show) {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];
            [device unlockForConfiguration];
        }else{
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }
}

+ (void)gotoDownloadApp:(NSString *)str
{
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", str];
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end


