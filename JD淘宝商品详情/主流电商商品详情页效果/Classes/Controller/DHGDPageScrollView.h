//
//  DHGDPageScrollView.h
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHGDPageScrollView : UIScrollView

@property(nonatomic,assign) NSInteger currentPageIndex;

- (void)nextPage;
- (void)previousPage;
- (void)setSubview:(nonnull UIView*)view toPageIndex:(NSInteger)index;

@end

