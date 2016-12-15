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
#import <MessageUI/MessageUI.h>

#define MainHeight  200

@interface FSShareView ()

@property (nonatomic,strong) UIScrollView       *scrollView;
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

- (void)setList:(NSArray<NSNumber *> *)list
{
    _list = list;
    if (FSValidateArray(list)) {
        return;
    }
    
    CGFloat width = (self.bounds.size.width - 100) / 4;
    WEAKSELF(this);
    for (int x = 0; x < list.count; x ++) {
        CGRect rect = CGRectMake(20 + x * (width + 20), 10, width, width + 25);
        FSImageLabelView *labelView = [self.scrollView viewWithTag:TAGLABEL + x];
        
        NSInteger type = [list[x] integerValue];
        if (!labelView) {
            labelView = [FSImageLabelView imageLabelViewWithFrame:rect imageName:[self imageNameForType:type] text:[self textForType:type]];
            labelView.tag = TAGLABEL + type;
            [self.scrollView addSubview:labelView];
            labelView.block = ^ (FSImageLabelView *bImageLabelView){
                [this imageLabelAction:bImageLabelView];
            };
        }
    }
    self.scrollView.contentSize = CGSizeMake(MAX(self.scrollView.width + 10, list.count * (width + 20) + 40), self.scrollView.height);
}

- (NSString *)imageNameForType:(FSShareType)type
{
    NSDictionary *dic = @{@"fsshare_wechat":@(FSShareTypeWechat),@"fsshare_wxfriend":@(FSShareTypeWXFriends),@"fsshare_qq":@(FSShareTypeQQ),@"fsshare_qqzone":@(FSShareTypeQQZone),@"fsshare_wechat":@(FSShareTypeWechat),@"fsshare_weibo":@(FSShareTypeWeibo),@"fsshare_msg":@(FSShareTypeMessage),@"fsshare_email":@(FSShareTypeEmail)};
    NSArray *keys = [dic allKeys];
    for (int x = 0; x < keys.count; x ++) {
        NSString *key = keys[x];
        NSInteger value = [dic[key] integerValue];
        if (value == type) {
            return key;
            break;
        }
    }
    return nil;
}

- (NSString *)textForType:(FSShareType)type
{
    NSDictionary *dic = @{@"微信":@(FSShareTypeWechat),@"朋友圈":@(FSShareTypeWXFriends),@"QQ":@(FSShareTypeQQ),@"QQ空间":@(FSShareTypeQQZone),@"微信收藏":@(FSShareTypeWechat),@"微博":@(FSShareTypeWeibo),@"短信":@(FSShareTypeMessage),@"邮件":@(FSShareTypeEmail)};
    NSArray *keys = [dic allKeys];
    for (int x = 0; x < keys.count; x ++) {
        NSString *key = keys[x];
        NSInteger value = [dic[key] integerValue];
        if (value == type) {
            return key;
            break;
        }
    }
    return nil;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat width = (self.bounds.size.width - 100) / 4;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, width + 25 + 20)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
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

+ (void)shareActionWithShareType:(FSShareType)tag title:(NSString *)shareTitle description:(NSString *)shareDesc  thumbImage:(UIImage *)shareImage url:(NSString *)url controller:(UIViewController *)controller result:(void(^)(NSString *bResult))completion
{
    if (!FSValidateString(shareTitle)) {
        return;
    }
    if (!FSValidateString(shareDesc)) {
        return;
    }
    if (![shareImage isKindOfClass:[UIImage class]]) {
        return;
    }
    if (!FSValidateString(url)) {
        return;
    }
    
    [FSShareManager shareInstance].callController = controller;
    
    if (tag == FSShareTypeWeibo) {
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWeibo shareResult:^(NSString *shareResult) {
            if (completion) {
                completion(shareResult);
            }
        }];
        
    }else if (tag == FSShareTypeQQ){//
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeQQ shareResult:^(NSString *shareResult) {
            if (completion) {
                completion(shareResult);
            }
        }];
    }else if (tag == FSShareTypeQQZone){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeQQZone shareResult:^(NSString *shareResult) {
            if (completion) {
                completion(shareResult);
            }
        }];
    }else if (tag == FSShareTypeWXFriends){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWXFriends shareResult:^(NSString *shareResult) {
            if (completion) {
                completion(shareResult);
            }
        }];
    }else if (tag == FSShareTypeWechat){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWechat shareResult:^(NSString *shareResult) {
            if (completion) {
                completion(shareResult);
            }
        }];
    }else if (tag == FSShareTypeWXStore){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWXStore shareResult:^(NSString *shareResult) {
            if (completion) {
                completion(shareResult);
            }
        }];
    }else if (tag == FSShareTypeMessage){
        [[FSShareManager shareInstance] messageShareWithMessage:@"分享的内容" recipients:nil controller:controller];
    }else if (tag == FSShareTypeEmail){
        [[FSShareManager shareInstance] mailShareWithSubject:@"最好的软件" messageBody:@"分享的内容" recipients:nil fileData:nil fileName:nil controller:controller];
    }
}

- (void)shareTo:(NSInteger)tag
{
    [FSShareManager shareInstance].callController = self.callController;
    
    if (tag == FSShareTypeWeibo) {
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWeibo shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:nil message:shareResult];
        }];
        
    }else if (tag == FSShareTypeQQ){//
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeQQ shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:nil message:shareResult];
        }];
    }else if (tag == FSShareTypeQQZone){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeQQZone shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:nil message:shareResult];
        }];
    }else if (tag == FSShareTypeWXFriends){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWXFriends shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:nil message:shareResult];
        }];
    }else if (tag == FSShareTypeWechat){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWechat shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:nil message:shareResult];
        }];
    }else if (tag == FSShareTypeWXStore){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:FSShareTypeWXStore shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:nil message:shareResult];
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
