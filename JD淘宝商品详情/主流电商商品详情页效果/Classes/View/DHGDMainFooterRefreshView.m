//
//  DHGDMainFooterRefreshView.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHGDMainFooterRefreshView.h"

#define DHGDMainFooterRefreshViewDefaultHeight 160
@interface DHGDMainFooterRefreshView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) CALayer *leftLayer;
@property (nonatomic,strong) CALayer *rightLayer;

@end

@implementation DHGDMainFooterRefreshView

-(instancetype)initWithFrame:(CGRect)frame {
    if(CGRectEqualToRect(CGRectZero, frame)) {
        frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), DHGDMainFooterRefreshViewDefaultHeight);
    }
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"上拉加载商品详情";
    _titleLabel.textColor = [UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_titleLabel];
    
    _leftLayer = [[CALayer alloc] init];
    _leftLayer.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1.00].CGColor;
    [self.layer addSublayer:_leftLayer];
    
    _rightLayer = [[CALayer alloc] init];
    _rightLayer.backgroundColor = _leftLayer.backgroundColor;
    [self.layer addSublayer:_rightLayer];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize titleSize = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName: _titleLabel.font}];
    
    _titleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) / 2 - titleSize.width / 2, 8, titleSize.width, 16);
    
    CGFloat lineHeight = 1 / [[UIScreen mainScreen] scale];
    CGFloat lineWidth = 50;
    
    _leftLayer.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame) - lineWidth - 5, CGRectGetMinY(_titleLabel.frame) + CGRectGetHeight(_titleLabel.frame) / 2, lineWidth, lineHeight);
    
    _rightLayer.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 5, CGRectGetMinY(_leftLayer.frame), CGRectGetWidth(_leftLayer.frame), CGRectGetHeight(_leftLayer.frame));
}

@end
