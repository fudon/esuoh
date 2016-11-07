//
//  ARTabBarController.h
//  myhome
//
//  Created by FudonFuchina on 2016/11/3.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTabBarController : UITabBarController

- (instancetype)initWithClasses:(NSArray<NSString*>*)classes titles:(NSArray<NSString*>*)titles types:(NSArray<NSNumber*>*)types;

@end
