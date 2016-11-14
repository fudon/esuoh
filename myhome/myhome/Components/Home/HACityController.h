//
//  HACityController.h
//  myhome
//
//  Created by fudon on 2016/11/10.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSBaseController.h"

@interface HACityController : FSBaseController

@property (nonatomic,copy) void (^selectedCityBlock)(NSDictionary *bCityDictionary);

@end
