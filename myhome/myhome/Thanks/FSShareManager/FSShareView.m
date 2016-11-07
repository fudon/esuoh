//
//  FSShareView.m
//  WTShare
//
//  Created by FudonFuchina on 16/9/4.
//  Copyright © 2016年 wutong. All rights reserved.
//

#import "FSShareView.h"
#import "FSTouchView.h"
#import "FSImageLabelView.h"

#define MainHeight  200

@interface FSShareView ()

@property (nonatomic,strong) FSTouchView        *touchView;
@property (nonatomic,strong) UIView             *mainView;

@end

@implementation FSShareView

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self shareDesignViews];
    }
    return self;
}

- (void)shareDesignViews
{
    _touchView = [[FSTouchView alloc] initWithFrame:self.bounds];
    [self addSubview:_touchView];
    _touchView.alpha = 0;
    __weak FSShareView *this = self;
    _touchView.tapBlock = ^ (){
        [this releaseView];
    };
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, MainHeight)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_mainView];
    
    CGFloat width = (self.bounds.size.width - 100) / 4;
    NSArray *array = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"微信收藏",@"微博",@"短信",@"邮件"];
    NSArray *picArray = @[@"fsshare_wechat",@"fsshare_wxfriend",@"fsshare_qq",@"fsshare_qqzone",@"fsshare_wechat",@"fsshare_weibo",@"fsshare_msg",@"fsshare_email"];
    for (int x = 0; x < array.count; x ++) {
        FSImageLabelView *imageLabel = [FSImageLabelView imageLabelViewWithFrame:CGRectMake(20 + (x % 4) * (width + 20), 10 + (x / 4) * (width + 40), width, width + 25) imageName:picArray[x] text:array[x]];
        [_mainView addSubview:imageLabel];
        imageLabel.tag = 1000 + x;
        imageLabel.block = ^ (FSImageLabelView *bImageLabelView){
            [this imageLabelAction:bImageLabelView];
        };
    }
    
    [UIView animateWithDuration:.3 animations:^{
        this.touchView.alpha = .28;
        this.mainView.frame = CGRectMake(0, self.bounds.size.height - MainHeight, self.bounds.size.width, MainHeight);
    }];
}

- (void)imageLabelAction:(FSImageLabelView *)imageView
{
    if (_block) {
        _block(self,imageView.tag - 1000);
    }
}

- (void)releaseView
{
    __weak FSShareView *this = self;
    [UIView animateWithDuration:.3 animations:^{
        this.mainView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, MainHeight);
        this.touchView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
