//
//  DHManagerViewController.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHManagerViewController.h"
#import "DHManagerTitleView.h"
#import "DHGDPageScrollView.h"
#import "DHGDMainViewController.h"
#import "DHGDWebViewController.h"
#import "DHGDEvaluationViewController.h"

NSString *const DHGDManagerViewCellIdentifier = @"DHGDManagerViewCellIdentifier";

@interface DHManagerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DHManagerTitleViewDelegate,DHGDMainViewControllerDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) DHManagerTitleView *titleView;
@property(nonatomic,strong) DHGDPageScrollView *pageScrollView;
@property(nonatomic,strong) DHGDMainViewController *mainController;
@property(nonatomic,strong) DHGDWebViewController *webController;
@property(nonatomic,strong) DHGDEvaluationViewController *evaluationController;

@end

@implementation DHManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}

- (void)initializeComponent {
    _titleView = [[DHManagerTitleView alloc] init];
    _titleView.titles = @[@"商品",@"详情",@"评价"];
    _titleView.delegate = self;
    
    [self addchildViewControllers];
    
    _pageScrollView = [[DHGDPageScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    [_pageScrollView setSubview:_mainController.view toPageIndex:0];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:DHGDManagerViewCellIdentifier];
    [self.view addSubview:_collectionView];
}

- (void)addchildViewControllers {
    
    CGRect bounds = self.view.bounds;
    UIEdgeInsets contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _mainController = [[DHGDMainViewController alloc] init];
    _mainController.delegate = self;
    _mainController.view.frame = bounds;
    _mainController.goodsCoverImg = _goodsCoverImg;
    [self addChildViewController:_mainController];
    
    _webController = [[DHGDWebViewController alloc] init];
    _webController.view.frame = bounds;
    _webController.contentInset = contentInset;
    [self addChildViewController:_webController];
    
    _evaluationController = [[DHGDEvaluationViewController alloc] init];
    _evaluationController.view.frame = bounds;
    _evaluationController.contentInset = contentInset;
    [self addChildViewController:_evaluationController];
    
    __weak typeof(self) weakSelf = self;
    _webController.headerRefreshCallback = ^ {
        if(!weakSelf) {
            return;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.navigationItem.titleView = strongSelf.titleView;
        strongSelf.collectionView.scrollEnabled = YES;
        [strongSelf.pageScrollView previousPage];
        [strongSelf.webController allowHeaderRefresh:NO];
    };
}

#pragma -mark collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = collectionView.bounds.size;
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DHGDManagerViewCellIdentifier forIndexPath:indexPath];
    
    NSArray *array = [cell.contentView subviews];
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
//    if(SystemVersion < 8.0) {
//        [self displayCell:cell atIndexPath:indexPath];
//    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self displayCell:cell atIndexPath:indexPath];
}

- (void)displayCell:(UICollectionViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    
    NSArray *subviews = cell.contentView.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
    UIView *view;
    switch (indexPath.row) {
        case 0:
        {
        view = _pageScrollView;
        }
            break;
        case 1:
        {
        view = _webController.view;
        _webController.baseURLString = @"https://www.baidu.com";
        }
            break;
        default:
        {
        view = _evaluationController.view;
        }
    }
    
    [cell.contentView addSubview:view];
}
#pragma mark--titleView delegate
- (void)titleView:(DHManagerTitleView *)view didSelectedAtIndex:(NSInteger)index {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (NSInteger)getScrollPage:(UIScrollView*)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / CGRectGetWidth(scrollView.bounds);
    return page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = [self getScrollPage:scrollView];
    [_titleView setCurrentIndex:page];
}

#pragma -mark DHGDViewController delegate

- (void)DHGDFooterRefreshing {
    self.navigationItem.titleView = nil;
    self.title = @"商品详情";
    self.collectionView.scrollEnabled = NO;
    
    self.webController.baseURLString = @"";
    
    [self.pageScrollView nextPage];
    [self.pageScrollView setSubview:self.webController.view toPageIndex:1];
    [self.webController allowHeaderRefresh:YES];
}

- (void)DHGDRequestCompleted {
    self.navigationItem.titleView = self.titleView;
    self.collectionView.scrollEnabled = YES;
}

@end
