//
//  DHGDMainViewController.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHGDMainViewController.h"
#import "DHGDMainFooterRefreshView.h"
#import "DHGDImageBrowserView.h"
#import "UIScrollView+DHGDHeader.h"
#import "DHMenuView.h"
#import "DHGDPopupViewController.h"

#define kFWFullScreenHeight     [UIScreen mainScreen].bounds.size.height
#define kFWFullScreenWidth      [UIScreen mainScreen].bounds.size.width

NSString *const DHGDMainViewHeaderSectionViewIdentifier = @"DHGDMainViewHeaderSectionViewIdentifier";
NSString *const DHGDMainViewFooterSectionViewIdentifier = @"DHGDMainViewFooterSectionViewIdentifier";

@interface DHGDMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) DHGDImageBrowserView *imageBrowserView;
@property(nonatomic,strong) UINavigationController *popupNavigationController;

@end

@implementation DHGDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addMaskImageView];
    [self initializeComponent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_maskView) {
        [_maskView removeFromSuperview];
    }
}

- (void)addMaskImageView {
    
    if (![_goodsCoverImg isEqualToString:@""]) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kFWFullScreenWidth, kFWFullScreenHeight)];
        _maskView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kFWFullScreenWidth, kFWFullScreenWidth)];
        imageView.image = [UIImage imageNamed:@"defaut"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_maskView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
    }
}

- (void)initializeComponent {
    
    [self.view layoutIfNeeded];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:DHGDMainViewHeaderSectionViewIdentifier];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:DHGDMainViewFooterSectionViewIdentifier];
    [self.view addSubview:_tableView];
    
    DHGDMainFooterRefreshView *footerView = [[DHGDMainFooterRefreshView alloc] init];
    footerView.hidden = YES;
    _tableView.tableFooterView = footerView;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, -CGRectGetHeight(footerView.frame)+62, 0);
    
    CGFloat imageWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    _imageBrowserView = [[DHGDImageBrowserView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    _tableView.DHGD_headerView = _imageBrowserView;
    [_tableView layoutIfNeeded];
    
    [self requestCompleted];
  
   
}

///模拟请求
- (void) requestCompleted {
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(strongSelf.maskView){
            [strongSelf.maskView removeFromSuperview];
        }

        if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(DHGDRequestCompleted)]) {
            [strongSelf.delegate DHGDRequestCompleted];
        }
        strongSelf.tableView.tableFooterView.hidden = NO;
    });
}

- (void)showTipMenuView:(NSString*)title data:(NSArray<DHGDPopupItemModel*>*)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat height = CGRectGetHeight(screenRect) / 2;
    CGRect startFrame = CGRectMake(0, CGRectGetHeight(screenRect), CGRectGetWidth(screenRect), height);
    CGRect endFrame = CGRectMake(0, CGRectGetHeight(screenRect) - height, CGRectGetWidth(screenRect), height);
    
    DHMenuView *menuView = [[DHMenuView alloc] initWithStartFrame:startFrame endFrame:endFrame];
    
    DHGDPopupViewController *popupController = [[DHGDPopupViewController alloc] init];
    popupController.view.frame = CGRectMake(0, 0, CGRectGetWidth(menuView.endFrame), CGRectGetHeight(menuView.endFrame));

    if(!_popupNavigationController) {
        _popupNavigationController = [[UINavigationController alloc] init];
        [_popupNavigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
        [_popupNavigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        [_popupNavigationController.navigationBar setClipsToBounds:YES];
        _popupNavigationController.view.frame = popupController.view.frame;
    }

    [_popupNavigationController setViewControllers:@[popupController]];

    DHGDPopupViewController *popupVC = _popupNavigationController.viewControllers[0];
    popupVC.title = title;
    popupVC.items = data;

    __weak typeof(menuView) weakMenuView = menuView;
    popupVC.closeBlock = ^ {
        [weakMenuView dismiss];
    };

    [menuView.contentView addSubview:_popupNavigationController.view];

    [menuView show];
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"example_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"example_cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"点击试试%ld%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
         [_tableView bringSubviewToFront:cell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     [self showTipMenuView:@"MENU" data:[self popupTaxData:@"菜单子项菜单子项菜单子项菜单子项菜单子项"]];
}

-(NSArray<DHGDPopupItemModel*>*)popupTaxData:(NSString*)text {
    if(!text) {
        return nil;
    }
    
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    
    DHGDPopupItemModel *item = [[DHGDPopupItemModel alloc] init];
    item.content = text;
    item.font = font;
    item.textColor = [UIColor grayColor];
    item.numberOfLines = 0;
    item.size = CGSizeMake(size.width, size.height + 10);
    item.textAlignment = NSTextAlignmentLeft;
    
    return @[item,item,item];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DHGDMainViewHeaderSectionViewIdentifier];
    view.contentView.backgroundColor = tableView.backgroundColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DHGDMainViewFooterSectionViewIdentifier];
    view.contentView.backgroundColor = tableView.backgroundColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}
#pragma scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGRect frame = _imageBrowserView.frame;
    if(offsetY <= 0 && offsetY >= -CGRectGetHeight(_imageBrowserView.frame)) {
        frame.origin.y = offsetY - (CGRectGetHeight(frame) + offsetY) / 2;
        _imageBrowserView.frame = frame;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat allowNextPageY = offsetY + scrollView.frame.size.height;
    if(allowNextPageY > scrollView.contentSize.height) {
        [self footerRefresh];
    }
}

#pragma -mark footer refresh

- (void)footerRefresh {
    
        //[_tableView.mj_footer endRefreshing];
    if(_delegate && [_delegate respondsToSelector:@selector(DHGDFooterRefreshing)]) {
        [_delegate DHGDFooterRefreshing];
    }
    
}

@end
