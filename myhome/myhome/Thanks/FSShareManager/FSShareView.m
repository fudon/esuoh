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
#import "FuSoft.h"
#import "FSShareEntity.h"

#define MainHeight  200

@interface FSShareView ()

@property (nonatomic,strong) FSTouchView        *touchView;
@property (nonatomic,strong) UIView             *mainView;
@property (nonatomic,weak)   UIViewController   *callController;
@property (nonatomic, strong) FSShareEntity     *shareData;

@end

@implementation FSShareView

- (void)dealloc
{
    FSLog();
}

- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)callController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.callController = callController;
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
    NSArray *tags = @[@(FSShareTypeWechat),@(FSShareTypeWXFriends),@(FSShareTypeQQ),@(FSShareTypeQQZone),@(FSShareTypeWXStore),@(FSShareTypeWeibo),@(FSShareTypeMessage),@(FSShareTypeEmail)];
    NSArray *picArray = @[@"fsshare_wechat",@"fsshare_wxfriend",@"fsshare_qq",@"fsshare_qqzone",@"fsshare_wechat",@"fsshare_weibo",@"fsshare_msg",@"fsshare_email"];
    for (int x = 0; x < array.count; x ++) {
        FSImageLabelView *imageLabel = [FSImageLabelView imageLabelViewWithFrame:CGRectMake(20 + (x % 4) * (width + 20), 10 + (x / 4) * (width + 40), width, width + 25) imageName:picArray[x] text:array[x]];
        [_mainView addSubview:imageLabel];
        imageLabel.tag = 1000 + [tags[x] integerValue];
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
    [self shareTo:imageView.tag - 1000];
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

- (void)shareTo:(NSInteger)tag
{
    [FSShareManager shareInstance].callController = self.callController;
    
    if (tag == FSShareTypeWeibo) {
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWeibo shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
        
    }else if (tag == FSShareTypeQQ){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeQQ shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == FSShareTypeQQZone){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeQQZone shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == FSShareTypeWXFriends){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWXFriends shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == FSShareTypeWechat){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWechat shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == FSShareTypeWXStore){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWXStore shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == FSShareTypeMessage){
        [[FSShareManager shareInstance] messageShareWithMessage:@"分享的内容" recipients:nil controller:self.callController];
    }else if (tag == FSShareTypeEmail){
        [[FSShareManager shareInstance] mailShareWithSubject:@"最好的软件" messageBody:@"分享的内容" recipients:nil fileData:nil fileName:nil controller:self.callController];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
