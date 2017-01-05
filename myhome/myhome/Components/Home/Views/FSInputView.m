//
//  FSInputView.m
//  myhome
//
//  Created by FudonFuchina on 2017/1/5.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import "FSInputView.h"
#import "FSViewManager.h"
#import "FSMacro.h"

@implementation FSInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self inputDesignViews];
    }
    return self;
}

- (void)inputDesignViews
{
    _label = [FSViewManager labelWithFrame:CGRectMake(15,0, 70, self.height) text:nil textColor:FS_TextColor_Normal backColor:nil font:FONTFC(16) textAlignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    
    _textField = [FSViewManager textFieldWithFrame:CGRectMake(_label.right + 10, 0, self.width - 95, self.height) placeholder:nil textColor:FS_TextColor_Normal backColor:nil];
    [self addSubview:_textField];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
