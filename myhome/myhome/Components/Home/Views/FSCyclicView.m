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

@end

@implementation FSCyclicView

- (void)setImageList:(NSArray<UIImage *> *)imageList
{
    if (_imageList != imageList) {
        _imageList = imageList;
        
        if (!_scrollView) {
            _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            _scrollView.pagingEnabled = YES;
            _scrollView.delegate = self;
            [self addSubview:_scrollView];
            
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 3, self.frame.size.height - 50, self.frame.size.width / 3, 50)];
            _pageControl.hidesForSinglePage = YES;
            _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
            [self addSubview:_pageControl];
        }
        _pageControl.numberOfPages = imageList.count;
        
        for (UIImageView *imageView in _scrollView.subviews) {
            if (imageView.tag >= 1000) {
                imageView.hidden = YES;
            }
        }
        
        for (int x = 0; x < imageList.count; x ++) {
            CGRect frame = CGRectMake(x * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            UIImageView *imageView = [_scrollView viewWithTag:1000 + x];
            if (!imageView) {
                imageView = [[UIImageView alloc] initWithFrame:frame];
                imageView.clipsToBounds = YES;
                imageView.tag = 1000 + x;
                [_scrollView addSubview:imageView];
            }
            imageView.frame = frame;
            imageView.image = imageList[x];
        }
        _scrollView.contentSize = CGSizeMake(imageList.count * self.frame.size.width, self.frame.size.height);
        
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger index = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (_pageControl.numberOfPages > index) {
        _pageControl.currentPage = index;
    }else{
        NSLog(@"HERE");
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
