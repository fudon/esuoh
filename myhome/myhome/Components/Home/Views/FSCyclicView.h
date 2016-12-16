//
//  FSCyclicView.h
//  myhome
//
//  Created by FudonFuchina on 2016/12/7.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSCyclicView : UIView

@property (nonatomic,strong) NSArray <NSString *>    *urls;

/*
    1.一个分页显示器，默认没有
 */
@property (nonatomic,assign) BOOL       needPageControl;

@end
