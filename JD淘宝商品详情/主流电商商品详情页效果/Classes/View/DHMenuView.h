//
//  DHMenuView.h
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/14.
//  Copyright © 2019 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHMenuView;

extern NSString *const MenuViewDidmissedNotificationName;

@protocol DHMenuViewDelegate <NSObject>

@optional
-(void)menuViewDismissed;

@end

@interface DHMenuView : UIView

@property(nonatomic,assign,readonly) CGRect startFrame;
@property(nonatomic,assign,readonly) CGRect endFrame;

@property(nonatomic,strong,readonly) UIView *contentView;
@property(nonatomic,weak) id<DHMenuViewDelegate> delegate;

///关闭后是否从父控件删除 default YES
@property(nonatomic,assign) BOOL isRemoveWithDismiss;


-(instancetype)init __attribute__((unavailable("WUMenuView cannot be created directly")));
-(instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("WUMenuView cannot be created directly")));

/**
 创建
 @param startFrame 动画起始位置
 @param endFrame   动画结束位置
 */
-(instancetype)initWithStartFrame:(CGRect)startFrame endFrame:(CGRect)endFrame;
-(void)show;
-(void)dismiss;

@end

