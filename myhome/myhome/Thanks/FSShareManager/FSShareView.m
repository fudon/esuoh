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
#import <MessageUI/MessageUI.h>

#define WhiteViewHeight  125

@interface FSShareView ()

@property (nonatomic,strong) UIScrollView       *scrollView;
@property (nonatomic,strong) FSTouchView        *touchView;
@property (nonatomic,weak)   UIViewController   *callController;
@property (nonatomic,copy) void (^callBack)(NSString *bResult);

@property (nonatomic,copy) NSString             *title;
@property (nonatomic,copy) NSString             *detail;
@property (nonatomic,copy) NSString             *url;
@property (nonatomic,strong) UIImage            *thumbImage;
@property (nonatomic,strong) NSArray            *recipientsOfEmail;
@property (nonatomic,strong) NSArray            *recipientsOfMessage;
@property (nonatomic,strong) NSData             *fileData;
@property (nonatomic,strong) NSString           *fileName;
@property (nonatomic,strong) NSString           *fileType;

@end

@implementation FSShareView

- (void)dealloc
{
    FSLog();
}

- (instancetype)initWithFrame:(CGRect)frame list:(NSArray<NSNumber *> *)list controller:(UIViewController *)controller title:(NSString *)title detail:(NSString *)detail url:(NSString *)url thumbImage:(UIImage *)image recipientsOfMail:(NSArray<NSString *> *)recipientsOfMail recipientsOfMessage:(NSArray<NSString *> *)recipientsOfMessage fileData:(NSData *)fileData fileName:(NSString *)fileName fileType:(NSString *)fileType result:(void(^)(NSString *bResult))completion
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.detail = detail;
        self.url = url;
        self.thumbImage = image;
        self.recipientsOfEmail = recipientsOfMail;
        self.recipientsOfMessage = recipientsOfMessage;
        self.fileData = fileData;
        self.fileName = fileName;
        self.fileType = fileType;
        
        self.callBack = completion;
        self.callController = controller;
        [self shareDesignViews:list];
    }
    return self;
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
    NSDictionary *dic = @{@"微信":@(FSShareTypeWechat),@"朋友圈":@(FSShareTypeWXFriends),@"QQ":@(FSShareTypeQQ),@"QQ空间":@(FSShareTypeQQZone),@"微信收藏":@(FSShareTypeWXStore),@"微博":@(FSShareTypeWeibo),@"短信":@(FSShareTypeMessage),@"邮件":@(FSShareTypeEmail)};
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

- (void)shareDesignViews:(NSArray *)list
{
    _touchView = [[FSTouchView alloc] initWithFrame:self.bounds];
    [self addSubview:_touchView];
    _touchView.alpha = 0;
    __weak FSShareView *this = self;
    _touchView.tapBlock = ^ (){
        [this releaseView];
    };
    
    CGFloat width = 70;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.width, WhiteViewHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    for (int x = 0; x < list.count; x ++) {
        CGRect rect = CGRectMake(20 + x * (width + 20), WhiteViewHeight / 2 - (width + 25) / 2, width, width + 25);// height:105
        
        NSInteger type = [list[x] integerValue];
        FSImageLabelView *labelView = [FSImageLabelView imageLabelViewWithFrame:rect imageName:[self imageNameForType:type] text:[self textForType:type]];
        labelView.tag = TAGLABEL + type;
        [_scrollView addSubview:labelView];
        labelView.block = ^ (FSImageLabelView *bImageLabelView){
            [this imageLabelAction:bImageLabelView];
        };
    }
    self.scrollView.contentSize = CGSizeMake(MAX(self.scrollView.width + 10, list.count * (width + 20) + 40), self.scrollView.height);
    
    [UIView animateWithDuration:.3 animations:^{
        this.touchView.alpha = .28;
        this.scrollView.frame = CGRectMake(0, self.bounds.size.height - this.scrollView.height, this.scrollView.width, this.scrollView.height);
    }];
}

- (void)imageLabelAction:(FSImageLabelView *)imageView
{
    FSShareType type = imageView.tag - TAGLABEL;
    if (type == (FSShareTypeEmail)) {
        [FSShareManager emailShareWithSubject:self.title messageBody:self.detail recipients:self.recipientsOfEmail fileData:self.fileData fileName:self.fileName fileType:self.fileType controller:self.callController];return;
    }else if (type == FSShareTypeMessage){
        [FSShareManager messageShareWithMessage:self.detail recipients:self.recipientsOfMessage data:self.fileData fileName:self.fileName fileType:self.fileType controller:self.callController];return;
    }
    [FSShareManager shareActionWithShareType:type title:self.title description:self.detail thumbImage:self.thumbImage url:self.url controller:_callController result:^(NSString *bResult) {
        if (self.callBack) {
            self.callBack(bResult);
        }
    }];
}

- (void)releaseView
{
    __weak FSShareView *this = self;
    [UIView animateWithDuration:.3 animations:^{
        this.scrollView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, WhiteViewHeight);
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
