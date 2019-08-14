//
//  DHGDWebViewController.h
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderRefreshBlock)(void);

@interface DHGDWebViewController : UIViewController

@property (nonatomic,copy) NSString *baseURLString;
@property (nonatomic,assign) UIEdgeInsets contentInset;
@property (nonatomic,copy) HeaderRefreshBlock headerRefreshCallback;

- (void)allowHeaderRefresh:(BOOL)flag;

@end

