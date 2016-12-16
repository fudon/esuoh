//
//  FSCyclicView.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/7.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSCyclicView.h"
#import <UIImageView+WebCache.h>
#import "FuSoft.h"

@interface FSCyclicView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView       *scrollView;
@property (nonatomic,strong) UIPageControl      *pageControl;

@property (nonatomic,assign) NSInteger          factIndex;  // 记录滑到了哪一张图片
@property (nonatomic,assign) NSInteger          currentIndex;  // 记录滑到了哪一页
@property (nonatomic,assign) CGFloat            currentOffsetX;  // 记录偏移量

@end

@implementation FSCyclicView

- (void)dealloc
{
    FSLog();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self cyclicDesignViews];
    }
    return self;
}

- (void)cyclicDesignViews
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(3 * self.frame.size.width, self.frame.size.height);
        [self addSubview:_scrollView];
        
        for (int x = 0; x < 3; x ++) {
            CGRect frame = CGRectMake(x * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.clipsToBounds = YES;
            imageView.tag = TAGIMAGEVIEW + x;
            [_scrollView addSubview:imageView];
            imageView.frame = frame;
        }
    }
}

- (void)setUrls:(NSArray<NSString *> *)urls
{
    _urls = urls;
    if (!FSValidateArray(urls)) {
        return;
    }
    NSInteger count = urls.count;
    _pageControl.numberOfPages = count;
    NSArray *images = @[urls[(count - 1) % count],urls[0],urls[1 % count]];
    [self setScrollViewImageViewImage:images];
}

/*
    显示的永远是中间那张图片
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger index = (NSInteger)floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self indexAction:index];
}

- (void)indexAction:(NSInteger)index
{
    if (self.currentIndex != index) {
        NSInteger count = _urls.count;
        if (self.currentIndex > index){
            self.factIndex --;
            if (self.factIndex < 0) {
                self.factIndex = count - 1;
            }
        }else{
            self.factIndex ++;
            if (self.factIndex == count) {
                self.factIndex = 0;
            }
        }
        _pageControl.currentPage = self.factIndex;
        self.currentIndex = index;
        
        NSInteger first = _factIndex >= 1 ? (_factIndex - 1):(count - 1);
        NSInteger last = _factIndex + 2 > count ? 0:(_factIndex + 1);
        
        NSArray *list = @[_urls[first % count],_urls[_factIndex % count],_urls[last % count]];
        [self setScrollViewImageViewImage:list];
    }
}

- (void)setScrollViewImageViewImage:(NSArray<NSString *> *)list
{
    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    self.currentIndex = 1;
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((obj.tag == TAGIMAGEVIEW + idx) && [obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = obj;
            [imageView sd_setImageWithURL:[NSURL URLWithString:list[idx]] placeholderImage:IMAGENAMED(@"home_backImage")];
        }
    }];
}

- (void)setNeedPageControl:(BOOL)needPageControl
{
    _needPageControl = needPageControl;
    if (needPageControl) {
        [self pageControl];
    }else{
        if (_pageControl) {
            [_pageControl removeFromSuperview];
            _pageControl = nil;
        }
    }
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 3, self.frame.size.height - 30, self.frame.size.width / 3, 30)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
