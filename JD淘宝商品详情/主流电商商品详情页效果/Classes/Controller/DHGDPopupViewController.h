//
//  DHGDPopupViewController.h
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/14.
//  Copyright © 2019 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DHGDPopupViewControllerCloseBlock)(void);

@interface DHGDPopupItemModel : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) NSUInteger numberOfLines;
@property (nonatomic,assign) NSTextAlignment textAlignment;

@end

@interface DHGDPopupViewController : UIViewController

@property (nonatomic,strong) NSArray<DHGDPopupItemModel*> *items;
@property (nonatomic,copy) DHGDPopupViewControllerCloseBlock closeBlock;

@end

