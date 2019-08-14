//
//  DHGDMainViewController.h
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHGDMainViewControllerDelegate <NSObject>

- (void)DHGDFooterRefreshing;
- (void)DHGDRequestCompleted;

@end

@interface DHGDMainViewController : UIViewController

@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,assign) UIEdgeInsets scrollIndicatorInsets;
@property (nonatomic,weak) id<DHGDMainViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *goodsCoverImg;
@end

