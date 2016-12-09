//
//  HAFlowController.h
//  myhome
//
//  Created by FudonFuchina on 2016/12/9.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSBaseController.h"

typedef NS_ENUM(NSInteger, HAFlowType) {
    HAFlowTypeNone,
    HAFlowTypeSeeHouse,// 勘房
    HAFlowTypeDesign,   // 设计
    HAFlowTypeSign,     // 签约
    HAFlowTypeSuccess,  // 完成
    HAFlowTypeCheck,    // 验收
    HAFlowTypeBetter,   // 装修
};

@interface HAFlowController : FSBaseController

@property (nonatomic,strong) NSNumber     *type;

@end
