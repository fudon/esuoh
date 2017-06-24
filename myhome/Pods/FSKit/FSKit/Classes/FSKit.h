//
//  FSKit.h
//  Pods
//
//  Created by fudon on 2017/6/17.
//
//

#import <UIKit/UIKit.h>
#import "FuSoft.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CoreLocation/CoreLocation.h>

@interface FSKit : NSObject

+ (void)userDefaultsKeepData:(id)instance  withKey:(NSString *)key;
+ (id)userDefaultsDataWithKey:(NSString *)key;
+ (id)objectFromJSonstring:(NSString *)jsonString;

+ (void)popToController:(NSString *)className navigationController:(UINavigationController *)navigationController animated:(BOOL)animated;

// 一个按钮
+ (void)alertView1WithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle handler:(void (^)(UIAlertAction *action))handler completion:(void (^)(void))completion;
// 两个按钮
+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle handler:(void (^)(UIAlertAction *action))cancelHandler cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))handler completion:(void (^)(void))completion;
+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message destructTitle:(NSString *)btnTitle handler:(void (^)(UIAlertAction *action))destructHandler cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion;
+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^)(UIAlertAction *action))handler destructTitle:destructTitle handler:(void (^)(UIAlertAction *action))destructHandler completion:(void (^)(void))completion;

+ (void)alertViewInputWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^)(UITextField *textField))configurationHandler completion:(void (^)(void))completion;
+ (void)alertViewInputsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^)(UITextField *textField))configurationHandler textFieldConifg:(void (^)(UITextField *textField))configuration completion:(void (^)(void))completion;
+ (void)alertView3InputsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^)(UITextField *textField))firstConfig textFieldConifg:(void (^)(UITextField *textField))secondConfig textFieldConifg:(void (^)(UITextField *textField))thirdConfig completion:(void (^)(void))completion;
+ (void)alertViewFourInputsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle handler:(void (^)(UIAlertAction *action))cancelHandler okTitle:(NSString *)okTitle handler:(void (^)(UIAlertController *bAlert,UIAlertAction *action))handler textFieldConifg:(void (^)(UITextField *textField))firstConfig textFieldConifg:(void (^)(UITextField *textField))secondConfig textFieldConifg:(void (^)(UITextField *textField))thirdConfig textFieldConifg:(void (^)(UITextField *textField))forthConfig completion:(void (^)(void))completion;

+ (void)actionSheet1WithTitle:(NSString *)title firstTitle:(NSString *)firstTitle style:(UIAlertActionStyle)style firstHandler:(void (^)(UIAlertAction *action))firstHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion;
+ (void)actionSheet2WithTitle:(NSString *)title firstTitle:(NSString *)firstTitle style:(UIAlertActionStyle)firstStyle firstHandler:(void (^)(UIAlertAction *action))firstHandler secondTitle:(NSString *)secondTitle style:(UIAlertActionStyle)secondStyle handler:(void (^)(UIAlertAction *action))secondHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion;
+ (void)actionSheet3WithTitle:(NSString *)title firstTitle:(NSString *)firstTitle style:(UIAlertActionStyle)firstStyle firstHandler:(void (^)(UIAlertAction *action))firstHandler secondTitle:(NSString *)secondTitle style:(UIAlertActionStyle)secondStyle handler:(void (^)(UIAlertAction *action))secondHandler thirdTitle:(NSString *)third style:(UIAlertActionStyle)thirdStyle handler:(void (^)(UIAlertAction *action))thrHandler  cancelHandler:(void (^)(UIAlertAction *action))cancelHandler completion:(void (^)(void))completion;

+ (void)pushToViewControllerWithClass:(NSString *)className navigationController:(UINavigationController *)navigationController param:(NSDictionary *)param configBlock:(void (^)(id vc))configBlockParam;
+ (void)presentToViewControllerWithClass:(NSString *)className controller:(UIViewController *)viewController param:(NSDictionary *)param configBlock:(void (^)(UIViewController *vc))configBlockParam presentCompletion:(void(^)(void))completion;
+ (void)copyToPasteboard:(NSString *)copyString;
+ (void)playSongs:(NSString *)songs type:(NSString *)fileType;
+ (void)xuanzhuanView:(UIView *)view;

+ (void)showFullScreenImage:(UIImageView *)avatarImageView;
+ (void)clearUserDefaults;
+ (void)letScreenLock:(BOOL)lock;                           // YES:让屏幕锁屏    NO：让屏幕不锁屏   【未测】
+ (void)gotoAppCentPageWithAppId:(NSString *)appID;         // 去App评分页
+ (void)setStatusBarBackgroundColor:(UIColor *)color;       // 设置状态栏颜色

+ (void)showMessage:(NSString *)message;
+ (void)showAlertWithMessage:(NSString *)message;

+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (BOOL)isValidateEmail:(NSString *)str;
+ (BOOL)isPureInt:(NSString *)string;
+ (BOOL)isPureFloat:(NSString*)string;
+ (BOOL)isLeapYear:(int)year;
+ (BOOL)isValidPassword:(NSString*)password;
+ (BOOL)keyedArchiverWithArray:(NSArray *)array toFilePath:(NSString *)fileName;
+ (BOOL)keyedArchiverWithData:(NSData *)data toFilePath:(NSString *)fileName;
+ (BOOL)keyedArchiverWithNumber:(NSNumber *)number toFilePath:(NSString *)fileName;
+ (BOOL)keyedArchiverWithString:(NSString *)string toFilePath:(NSString *)fileName;
+ (BOOL)keyedArchiverWithDictionary:(NSDictionary *)dic toFilePath:(NSString *)fileName;
+ (BOOL)createFile:(NSString *)fileName withContent:(NSString *)string;
+ (BOOL)moveFile:(NSString *)filePath toPath:(NSString *)newPath;
+ (BOOL)renameFile:(NSString *)filePath toPath:(NSString *)newPath;
+ (BOOL)copyFile:(NSString *)filePath toPath:(NSString *)newPath;
+ (BOOL)removeFile:(NSString *)filePath;
+ (BOOL)isChinese:(NSString *)string;
+ (BOOL)isValidateUserPasswd :(NSString *)str;
+ (BOOL)isChar:(NSString *)str;
+ (BOOL)isNumber:(NSString *)str;
+ (BOOL)isDateAEarlierThanDateB:(NSDate *)aDate bDate:(NSDate *)bDate;
+ (BOOL)isString:(NSString *)aString containString:(NSString *)bString;
+ (BOOL)isStringContainsStringAndNumber:(NSString *)sourceString;
+ (int)isTheSameDayA:(NSDate *)aDate b:(NSDate *)bDate;
+ (BOOL)isDateA:(NSDate *)aDate earlierToB:(NSDate *)bDate;
+ (BOOL)checkTextFieldHasValidInput:(UITextField *)textField;
+ (BOOL)isURLString:(NSString *)sourceString;//0
// 判断字符串是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string;
// 判断字符串是否全为数字
+ (BOOL)isAllNum:(NSString *)string;
+ (BOOL)networkSettedProxy;                 // 网络是否设置了代理
+ (BOOL)isValidateString:(NSString *)string;
+ (BOOL)isValidateArray:(NSArray *)array;
+ (BOOL)isValidateDictionary:(NSDictionary *)dictionary;
+ (BOOL)floatEqual:(float)aNumber bNumber:(float)bNumber;

+ (CGFloat)absoluteValue:(CGFloat)value;
// 五险一金后工资应缴税额
+ (CGFloat)taxForSalaryAfterSocialSecurity:(CGFloat)money;
// 根据税后推算税前
+ (NSArray *)taxRatesWithMoneyAfterTax:(CGFloat)money;
// 返回税率（index[0]）和速算扣除数(index[1])
+ (NSArray *)taxRateForMoney:(CGFloat)money;

+ (NSTimeInterval)mmSecondsSince1970;
+ (NSInteger)secondsSince1970;
+ (NSTimeInterval)chinaSecondsSince1970;
+ (NSInteger)weekdayStringFromDate:(NSDate *)inputDate;
+ (NSDateComponents *)yearMonthDayFromDate:(NSDate *)date;

+ (double)forwardValue:(double)number afterPoint:(int)position;  // 只入不舍
+ (double)usedMemory;                                                               // 获得应用占用的内存，单位为M
+ (double)availableMemory;                                                          // 获得当前设备可用内存,单位为M
+ (float)folderSizeAtPath:(NSString*)folderPath extension:(NSString *)extension;    // 获取文件夹目录下的文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath;                                    // 获取文件的大小
+ (CGFloat)textHeight:(NSString *)text
              fontInt:(NSInteger)fontInt                                            // 计算字符串放在label上需要的高度,font数字要和label的一样
           labelWidth:(CGFloat)labelWidth;                                          // label调用 sizeToFit 可以实现自适应
+ (double)distanceBetweenCoordinate:(CLLocationCoordinate2D)coordinateA toCoordinateB:(CLLocationCoordinate2D)coordinateB;
// 获取磁盘大小（单位：Byte）
+ (CGFloat)diskOfAllSizeBytes;
// 磁盘可用空间
+ (CGFloat)diskOfFreeSizeBytes;
//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath;
// 手机可用内存
+ (double)availableMemoryNew;
// 当前app所占内存（RAM）
+ (double)currentAppMemory;
+ (CGSize)keyboardNotificationScroll:(NSNotification *)notification baseOn:(CGFloat)baseOn;
+ (CGFloat)DEBJWithYearRate:(CGFloat)rate monthes:(NSInteger)month;
+ (CGFloat)DEBXWithYearRate:(CGFloat)rate monthes:(NSInteger)month;
+ (CGFloat)freeStoragePercentage;   // 可用内存占总内存的比例,eg  0.1;
+ (NSInteger)getTotalDiskSize;   // 获取磁盘总量
+ (NSInteger)getAvailableDiskSize;   // 获取磁盘可用量

+ (NSString *)appVersionNumber;                                                     // 获得版本号
+ (NSString *)appName;                                                              // 获得应用的Bundle Display Name
+ (NSString *)iPAddress;
+ (NSString *)randomNumberWithDigit:(int)digit;
+ (NSString *)blankInChars:(NSString *)string byCellNo:(int)num;
+ (NSString *)jsonStringWithObject:(id)dic;
+ (NSString *)JSONString:(NSString *)aString;
+ (NSString *)dataToString:(NSData *)data;
+ (NSString *)dataToString:(NSData *)data withEncoding:(NSStringEncoding)encode;
+ (NSString *)homeDirectoryPath:(NSString *)fileName;
+ (NSString *)keyedUnarchiverWithString:(NSString *)fileName;
+ (NSString *)documentsPath:(NSString *)fileName;
+ (NSString *)temporaryDirectoryFile:(NSString *)fileName;
+ (NSString *)localFilePath:(NSString *)fileName;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)stringDeleteNewLineAndWhiteSpace:(NSString *)string;
+ (NSString *)adID;
+ (NSString *)pathForResource:(NSString *)name type:(NSString *)type;
//+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey;
+ (NSString *)timeStamp;
+ (NSString *)macaddress;
+ (NSString *)identifierForVendorFromKeyChain;
+ (NSString *)asciiCodeWithString:(NSString *)string;
+ (NSString *)stringFromASCIIString:(NSString *)string;
+ (NSString *)DataToHex:(NSData *)data;                          // 将二进制转换为16进制再用字符串表示
+ (NSString *)cleanString:(NSString *)str;
+ (NSString *)placeholderString:(NSString *)string font:(NSInteger)font back:(NSInteger)back;
+ (NSString *)stringByDate:(NSDate *)date;                       // 解决差8小时的问题
+ (NSString *)bankStyleData:(id)data;
+ (NSString *)zeroHandle:(id)data;
+ (NSString *)bankStyleDataThree:(id)data;
+ (NSString *)fourNoFiveYes:(float)number afterPoint:(int)position;  // 四舍五入
+ (NSString *)newFloat:(float)value withNumber:(int)numberOfPlace;
+ (NSString *)backBankData:(NSString *)text;
+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue  valueB:(NSString *)multiplicandValue;
+ (NSString *)deviceModel;
+ (NSString *)easySeeTimesBySeconds:(NSInteger)seconds;
+ (NSString *)tenThousandNumber:(double)value;
+ (NSString *)tenThousandNumberString:(NSString *)value;
+ (NSString *)urlEncodedString:(NSString *)urlString;
+ (NSString *)urlDecodedString:(NSString *)urlString;
+ (NSString *)replaceString:(NSMutableString *)string byString:(NSString *)replaceString;
+ (NSString *)placeholderStringFor:(NSString *)sourceString;
+ (NSString *)placeholderStringFor:(NSString *)sourceString with:(NSString *)placeholderString;
+ (NSString *)addStringWithSpace:(NSString *)aString bString:(NSString *)bString;
+ (NSString *)base64StringForText:(NSString *)text;     // 将字符串转换为base64编码
+ (NSString *)textFromBase64String:(NSString *)text;    // 将base64转换为字符串
+ (NSString *)base64Code:(NSData *)data;                // 用来将图片转换为字符串
+ (NSString *)sessionID:(NSURLResponse *)response;
+ (NSString *)hostNameFromUrlString:(NSString *)urlString;

+ (NSString *)ymdhsByTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)ymdhsByTimeIntervalString:(NSString *)timeInterval;

+ (NSString *)countOverTime:(NSTimeInterval)time;   // 把秒转换为天时分
+ (NSString *)convertNumbers:(NSString *)string;    // SQLite3的表名不能是数字，所以可以用这方法转成拼音
+ (NSString *)pinyinForHans:(NSString *)chinese;        // 获取汉字的拼音
+ (NSString *)pinyinForHansClear:(NSString *)chinese;        // 获取汉字的拼音，没有空格
+ (NSString*)reverseWordsInString:(NSString*)str;       // 字符串反转
+ (NSString *)twoChar:(NSInteger)value;
+ (NSString *)scanQRCode:(UIImage *)image;  // 解析二维码
+ (NSString *)dataToHex:(NSData *)data;
+ (NSData *)convertHexStrToData:(NSString *)str;
+ (NSString *)readableForTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)stringWithDate:(NSDate *)date formatter:(NSString *)formatter;

/*  NSAttributedString *connectAttributedString = [FuData attributedStringFor:connectString colorRange:@[[NSValue valueWithRange:connectRange]] color:GZS_RedColor textRange:@[[NSValue valueWithRange:connectRange]] font:FONTFC(25)];*/
+ (NSAttributedString *)attributedStringFor:(NSString *)sourceString colorRange:(NSArray *)colorRanges color:(UIColor *)color textRange:(NSArray *)textRanges font:(UIFont *)font;
+ (NSAttributedString *)attributedStringFor:(NSString *)sourceString strings:(NSArray *)colorStrings color:(UIColor *)color fontStrings:(NSArray *)fontStrings font:(UIFont *)font;

+ (NSString *)firstCharacterWithString:(NSString *)string;

//     strikeLabel.attributedText = attribtStr;
- (NSAttributedString *)middleLineForLabel:(NSString *)text;    // 中划线
- (NSAttributedString *)underLineForLabel:(NSString *)text;     // 下划线


/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 *  eg. NSLog(@"\n\nresult: %@", [Utilities timeIntervalFromLastTime:@"2015年12月8日 15:50"
 lastTimeFormat:@"yyyy年MM月dd日 HH:mm"
 ToCurrentTime:@"2015/12/08 16:12"
 currentTimeFormat:@"yyyy/MM/dd HH:mm"]);
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;

// 高精度计算
+ (NSString *)highAdd:(NSString *)aValue add:(NSString *)bValue;
+ (NSString *)highSubtract:(NSString *)fontValue add:(NSString *)backValue;
+ (NSString *)highMultiply:(NSString *)aValue add:(NSString *)bValue;
+ (NSString *)highDivide:(NSString *)aValue add:(NSString *)bValue;

+ (void)call:(NSString *)phone;
+ (void)callPhoneWithNoNotice:(NSString *)phone;
+ (void)gotoDownloadApp:(NSString *)appid;
+ (void)openAppByURLString:(NSString *)str;

// 操作闪光灯
+ (void)flashLampShow:(BOOL)show;

// 除了年不是当年数字，月日是当月日
+ (NSDateComponents *)chineseDate:(NSDate *)date;
// 获取农历日期，数组共三个元素，分别是农历的年月日
+ (NSArray<NSString *> *)chineseCalendarForDate:(NSDate *)date;
+ (NSArray *)arrayFromArray:(NSArray *)array withString:(NSString *)string;
+ (NSArray *)arrayByOneCharFromString:(NSString *)string;
+ (NSArray *)keyedUnarchiverWithArray:(NSString *)fileName;
+ (NSArray *)arrayFromJsonstring:(NSString *)string;
+ (NSArray *)arrayReverseWithArray:(NSArray *)array;
+ (NSArray *)maxandMinNumberInArray:(NSArray *)array;                           // 找出数组中最大的数 First Max, Last Min
+ (NSArray *)maopaoArray:(NSArray *)array;
+ (NSArray *)addCookies:(NSArray *)nameArray value:(NSArray *)valueArray cookieDomain:(NSString *)cookName;
+ (NSArray *)deviceInfos;

+ (NSArray<NSString *> *)propertiesForClass:(Class)className;   // 获取类的所有属性
+ (SEL)setterSELWithAttibuteName:(NSString*)attributeName;      // 将字符串转化为Set方法，如将"name"转化为setName方法
+ (NSString *)valueForGetSelectorWithPropertyName:(NSString *)name object:(id)instance;  // 获取实例的属性的值

+ (NSDictionary *)keyedUnarchiverWithDictionary:(NSString *)fileName;

+ (NSData *)dataFromString:(NSString *)string;
+ (NSData *)keyedUnarchiverWithData:(NSString *)fileName;
+ (NSData*)rsaEncryptString:(SecKeyRef)key data:(NSString*) data;
//压缩图片到指定文件大小
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

+ (NSNumber *)keyedUnarchiverWithNumber:(NSString *)fileName;
+ (NSNumber *)fileSize:(NSString *)filePath;
+ (NSValue *)rangeValue:(NSRange)range;

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHexString:(NSString *)color;               // 根据16进制字符串获得颜色类对象

// 主要用于汉字倾斜,系统UIFont没有直接支持汉字倾斜。可以使字体倾斜rate角度，rate在0-180之间，取15较好；fontSize是字体大小。
+ (UIFont *)angleFontWithRate:(CGFloat)rate fontSize:(NSInteger)fontSize;

+ (NSDate *)dateFromStringByHotline:(NSString *)string;
+ (NSDate *)dateFromStringByHotlineWithoutSeconds:(NSString *)string;
+ (NSDate *)chinaDateByDate:(NSDate *)date;                                     // 解决差8小时问题
+ (NSDate *)chinaDateByTimeInterval:(NSString *)timeInterval;                   // 解决差8小时问题
+ (NSDateComponents *)componentForDate:(NSDate *)date;
+ (NSInteger)daythOfYearForDate:(NSDate *)date;                                 // 获取日期是当年的第几天

// 绘制虚线
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;
+ (UIImage *)QRImageFromString:(NSString *)string;
+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;
+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth; // 将图片大小设置为目标大小，用于压缩图片
+ (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth;
#pragma mark - 对图片进行滤镜处理
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;
#pragma mark -  对图片进行模糊处理
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;
// 调整图片饱和度、亮度、对比度
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;
// 创建一张实时模糊效果 View (毛玻璃效果)
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;
// 全屏截图
+ (UIImage *)shotFullScreen;
//截取view中某个区域生成一张图片
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;
//截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view;
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;

// 压缩图片
+ (UIImage *)compressImageData:(NSData *)imageData;
+ (UIImage *)compressImage:(UIImage *)imageData;
+ (UIImage *)compressImage:(UIImage *)image width:(NSInteger)minWidth minHeight:(NSInteger)minHeight;

+ (UIImage *)compressImage:(UIImage *)image width:(NSInteger)width;
+ (UIImage*)imageForUIView:(UIView *)view;

// 单位转换方法
+ (NSString *)KMGUnit:(NSInteger)size;

+ (NSURL *)convertTxtEncoding:(NSURL *)fileUrl;

// 将文件拷贝到tmp目录
+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL;

+ (id)storyboardInstantiateViewControllerWithStoryboardID:(NSString *)storybbordID;

@end
