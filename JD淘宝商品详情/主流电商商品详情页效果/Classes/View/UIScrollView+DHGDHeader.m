//
//  UIScrollView+DHGDHeader.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "UIScrollView+DHGDHeader.h"
#import <objc/runtime.h>

@implementation UIScrollView (DHGDHeader)

static const char DHGD_headerViewKey = '\0';

- (void)setDHGD_headerView:(UIView *)DHGD_headerView {
    ///对属性进行手动getter/setter 操作
    objc_setAssociatedObject(self, &DHGD_headerViewKey, DHGD_headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if(DHGD_headerView) {
        CGRect frame = DHGD_headerView.frame;
        frame.origin.y = -CGRectGetHeight(frame);
        DHGD_headerView.frame = frame;
        
        UIEdgeInsets contentInset = self.contentInset;
        contentInset.top += CGRectGetHeight(DHGD_headerView.frame);
        self.contentInset = contentInset;
        
        [self setContentOffset:CGPointMake(0, -contentInset.top)];
        [self addSubview:DHGD_headerView];
        
    } else {
        if(self.DHGD_headerView) {
            [self.DHGD_headerView removeFromSuperview];
        }
    }
}

- (UIView *)DHGD_headerView {
    return objc_getAssociatedObject(self, &DHGD_headerViewKey);
}

@end
