//
//  DHGDWebViewController.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHGDWebViewController.h"
#import <MJRefresh.h>

@interface DHGDWebViewController ()<UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) BOOL isCompleted;
@end

@implementation DHGDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [ self initlize];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *htmlString = @"http://www.baidu.com";
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)initlize {
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
    
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
      _webView.scrollView.mj_header = header;
}

#pragma -mark header refresh
- (void)headerRefresh {
    
    [_webView.scrollView.mj_header endRefreshing];
    if(_headerRefreshCallback) {
        _headerRefreshCallback();
    }
}

- (void)allowHeaderRefresh:(BOOL)flag {
    _webView.scrollView.mj_header.hidden = !flag;
}

@end
