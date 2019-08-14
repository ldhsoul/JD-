//
//  DHMenuView.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/14.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHMenuView.h"

NSString *const MenuViewDidmissedNotificationName = @"MenuViewDidmissedNotificationName";

@interface DHMenuView ()<UIGestureRecognizerDelegate>

@end

@implementation DHMenuView

- (instancetype)initWithStartFrame:(CGRect)startFrame endFrame:(CGRect)endFrame {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:frame];
    _startFrame = startFrame;
    _endFrame = endFrame;
    if(self) {
        [self initialzie];
    }
    
    return self;
}

- (void)initialzie {
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.isRemoveWithDismiss = YES;
    
    _contentView = [[UIView alloc] initWithFrame:_startFrame];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self];
    CGRect frame = CGRectMake(point.x, point.y, 1, 1);
    if(CGRectContainsRect(_endFrame, frame)) {
        return NO;
    }
    
    return YES;
}

- (void)viewTap:(UIGestureRecognizer*)sender {
    [self dismiss];
}

- (void)show {
    
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    view.backgroundColor = [UIColor blackColor];
    
    [view addSubview:self];
    self.hidden = NO;
    __weak typeof(self) weakSelf = self;
    
    UIView *rootView = [self rootView];
    rootView.layer.transform = CATransform3DMakeTranslation(0, 0, -1000);
    CATransform3D transform = [self makeTransform];
    
    [UIView animateWithDuration:0.6 animations:^{
        weakSelf.contentView.frame = weakSelf.endFrame;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{

        rootView.layer.transform = transform;

    } completion:^(BOOL finished) {

        CATransform3D t = rootView.layer.transform;
        t = CATransform3DRotate(t, -15.0 * M_PI/180.0, 1, 0, 0);

        [UIView animateWithDuration:0.3 animations:^{

            rootView.layer.transform = t;
        }];

    }];
}

- (UIView*)rootView {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window rootViewController].view;
    return rootView;
}

- (CATransform3D)makeTransform{
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m43 = -1000; // m43 z轴方向进行平移
    t1.m34 = -1.0 / 900; // 透视效果m34= -1/D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.9, 0.94, 1);

    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI / 180.0, 1, 0, 0);
    
    return t1;
    
}

- (void)dismiss {
    
    __weak typeof(self) weakSelf = self;
    UIView *rootView = [self rootView];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m43 = -1000;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = weakSelf.startFrame;
        rootView.layer.transform = transform;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        
        [[UIApplication sharedApplication] keyWindow].backgroundColor = [UIColor whiteColor];
        rootView.layer.transform = CATransform3DIdentity;
        if(weakSelf.isRemoveWithDismiss) {
            [weakSelf removeFromSuperview];
            if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(menuViewDismissed)]) {
                [weakSelf.delegate menuViewDismissed];
            }
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MenuViewDidmissedNotificationName object:nil];
}

@end
