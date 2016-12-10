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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (self.currentOffsetX == 0) {
        self.currentOffsetX = self.bounds.size.width;
    }
    if (offsetX < self.currentOffsetX) {    // 向前滑
        self.factIndex --;
        if (self.factIndex < 0)
            self.factIndex = _imageList.count - 1;
    }else{                                  // 向后滑
        self.factIndex ++;
        if (self.factIndex > _imageList.count - 1)
            self.factIndex = 0;
    }
    self.currentOffsetX = offsetX;
    self.pageControl.currentPage = self.factIndex;
    
    self.imageList = _imageList;
    
    
//    CGFloat pageWidth = scrollView.frame.size.width;
//    NSInteger index = (NSInteger)floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    if (_pageControl.numberOfPages > index) {
//        _pageControl.currentPage = index;
//    }else{
//        NSLog(@"HERE");
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
