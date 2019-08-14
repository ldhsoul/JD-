//
//  DHManagerTitleView.h
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHManagerTitleView;

@protocol DHManagerTitleViewDelegate <NSObject>

@required
- (void)titleView:(DHManagerTitleView *)view didSelectedAtIndex:(NSInteger)index;

@end

@interface DHManagerTitleView : UIView

@property(nonatomic,strong) NSArray<NSString*> *titles;
@property(nonatomic,weak) id<DHManagerTitleViewDelegate> delegate;
@property(nonatomic,assign) NSInteger currentIndex;

@property(nonatomic,assign) BOOL isShowIndicator;

@end
