//
//  DHGDImageBrowserView.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHGDImageBrowserView.h"

@implementation DHGDImageBrowserView
{
    UIImageView *_imgCover;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _imgCover = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgCover.contentMode = UIViewContentModeScaleAspectFill;
    _imgCover.image = [UIImage imageNamed:@"defaut"];
    [self addSubview:_imgCover];
  
}

@end
