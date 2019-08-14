//
//  DHGDPageScrollView.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHGDPageScrollView.h"

#define DHPAGECOUNT 2

@implementation DHGDPageScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _currentPageIndex = 0;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.alwaysBounceVertical = NO;
    self.alwaysBounceHorizontal = NO;
    self.bounces = NO;
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * DHPAGECOUNT);
    
    [self addPageView];
}

- (void)addPageView {
    
    CGSize size = self.frame.size;
    for (int i = 0; i < DHPAGECOUNT; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, size.height * i, size.width, size.height)];
        view.tag = 100 + i;
        [self addSubview:view];
    }
}

-(void)setCurrentPageIndex:(NSInteger)currentPageIndex {
    
    NSInteger maxPageIndex = DHPAGECOUNT - 1;
    currentPageIndex = currentPageIndex <= 0 ? 0 : currentPageIndex >= maxPageIndex ? maxPageIndex : currentPageIndex;
    
    if(_currentPageIndex == currentPageIndex) {
        return;
    }
    
    _currentPageIndex = currentPageIndex;
    
    [self scrollToPage:_currentPageIndex];
}

-(void)scrollToPage:(NSInteger)index {
    CGRect rect = [self rectFromPage:index];
    
    [self scrollRectToVisible:rect animated:YES];
}

-(CGRect)rectFromPage:(NSInteger)index {
    CGRect viewBounds = self.bounds;
    CGRect rect = CGRectMake(0, CGRectGetHeight(viewBounds) * index, CGRectGetWidth(viewBounds), CGRectGetHeight(viewBounds));
    return rect;
}

- (void)nextPage {
    self.currentPageIndex = _currentPageIndex + 1;
}

- (void)previousPage {
    self.currentPageIndex = _currentPageIndex - 1;
}

-(void)setSubview:(UIView *)view toPageIndex:(NSInteger)index {
    
    if(index < 0 || index > DHPAGECOUNT - 1) {
        return;
    }
    UIView *pageView = [self viewWithTag:100 + index];
    NSArray *array = pageView.subviews;
    for (UIView *sv in array) {
        [sv removeFromSuperview];
    }
    
    [pageView addSubview:view];
}

@end
