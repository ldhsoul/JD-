//
//  DHGDPopupViewController.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/14.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHGDPopupViewController.h"


@implementation DHGDPopupItemModel

-(instancetype)init {
    self = [super init];
    if(self) {
        _numberOfLines = NSNotFound;
    }
    
    return self;
}

@end

@interface DHGDPopupViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation DHGDPopupViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_titleLabel];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = self.bounds;
}

@end


NSString *const DHGDPopupViewCellIdentifier = @"DHGDPopupViewCellIdentifier";

@interface DHGDPopupViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation DHGDPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}

-(void)initializeComponent {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonTouch:)];
    [rightBarButton setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[DHGDPopupViewCell class] forCellWithReuseIdentifier:DHGDPopupViewCellIdentifier];
    [self.view addSubview:_collectionView];
    
}

-(void)rightBarButtonTouch:(UIBarButtonItem*)sender {
    if(_closeBlock) {
        _closeBlock();
    }
}

-(void)setItems:(NSArray<DHGDPopupItemModel *> *)items {
    _items = items;
    
    [_collectionView.collectionViewLayout invalidateLayout];
    
    [_collectionView reloadData];
}

#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_items) {
        return _items.count;
    }
    
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DHGDPopupItemModel *item = _items[indexPath.row];
    return item.size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DHGDPopupViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DHGDPopupViewCellIdentifier forIndexPath:indexPath];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        [self configCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self configCell:(DHGDPopupViewCell*)cell atIndexPath:indexPath];
}

-(void)configCell:(DHGDPopupViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    DHGDPopupItemModel *item = _items[indexPath.row];
    
    cell.titleLabel.text = item.content;
    cell.titleLabel.textAlignment = item.textAlignment;
    
    if(item.font) cell.titleLabel.font = item.font;
    if(item.textColor) cell.titleLabel.textColor = item.textColor;
    if(item.numberOfLines != NSNotFound) cell.titleLabel.numberOfLines = item.numberOfLines;
}

@end
