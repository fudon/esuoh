//
//  FSCyclicView.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/7.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSCyclicView.h"

@interface FSCyclicView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView       *scrollView;
@property (nonatomic,strong) UIPageControl      *pageControl;

@property (nonatomic,assign) NSInteger          factIndex;  // 记录滑到了哪一张图片
@property (nonatomic,assign) NSInteger          currentIndex;  // 记录滑到了哪一页
@property (nonatomic,assign) CGFloat            currentOffsetX;  // 记录偏移量

@end

@implementation FSCyclicView

- (void)setImageList:(NSArray<UIImage *> *)imageList
{
    if (!([imageList isKindOfClass:[NSArray class]] && imageList.count)) {
        return;
    }
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(3 * self.frame.size.width, self.frame.size.height);
        [self addSubview:_scrollView];
        
        for (int x = 0; x < 3; x ++) {
            CGRect frame = CGRectMake(x * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.clipsToBounds = YES;
            imageView.tag = 1000 + x;
            [_scrollView addSubview:imageView];
            imageView.frame = frame;
        }
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 3, self.frame.size.height - 30, self.frame.size.width / 3, 30)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_pageControl];
    }
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    _pageControl.numberOfPages = imageList.count;
    _pageControl.currentPage = 0;
    
    if (self.factIndex == 0) {
        NSArray *images = @[imageList[(imageList.count - 1) % imageList.count],imageList[0],imageList[1%imageList.count]];
        [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ((obj.tag == 1000 + idx) && [obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = obj;
                imageView.image = images[idx];
            }
        }];
    }else{
        NSArray *images = @[imageList[(self.factIndex - 1) % imageList.count],imageList[self.factIndex],imageList[(self.factIndex + 1)%imageList.count]];
        [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ((obj.tag == 1000 + idx) && [obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = obj;
                imageView.image = images[idx];
            }
        }];
    }
//    if (_imageList != imageList) {
//        _imageList = imageList;
//        
//    }
}

/*
    显示的永远是中间那张图片
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger index = (NSInteger)floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.currentIndex != index) {
        if (self.currentIndex > index)
            self.factIndex --;
        else
            self.factIndex ++;
        NSLog(@"%@",@(self.factIndex));
        self.currentIndex = index;
        
        if (self.currentIndex != 1) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        }
        self.imageList = self.imageList;
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
