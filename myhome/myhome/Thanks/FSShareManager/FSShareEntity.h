//
//  FSShareEntity.h
//  myhome
//
//  Created by fudon on 2016/11/7.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSShareEntity : NSObject

@property (strong, nonatomic) UIImage *thumbImage;
@property (strong, nonatomic) UIImage *bigImage;
@property (strong, nonatomic) NSString *imageType;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *weixinPyqtitle;
@property (strong, nonatomic) NSString *qqTitle;

@property (strong, nonatomic) NSString *urlString;//
@property (strong, nonatomic) NSString *urlImageString;// QQ,QQ空间分享加载图片用的
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *type;

@property (nonatomic, assign)BOOL isImageShareQQ; // yes 代表用图片 NO代表用URL
@property (nonatomic, strong)NSString * sinaSummary;

+ (FSShareEntity *)shareWTShareContentItem;

@end
