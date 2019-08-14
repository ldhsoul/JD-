//
//  DHManagerTitleView.m
//  主流电商商品详情页效果
//
//  Created by fubang on 2019/8/13.
//  Copyright © 2019 ldh. All rights reserved.
//

#import "DHManagerTitleView.h"

#define DHGDMainTitleViewItemSelectedColor [UIColor blackColor]
#define DHGDMainTitleViewItemDeSelectedColor [UIColor grayColor]
#define DHGDMainTitleViewItemSelectedFont [UIFont systemFontOfSize:18]
#define DHGDMainTitleViewItemDeSelectedFont [UIFont systemFontOfSize:17]

@interface DHManagerTitleViewCell : UICollectionViewCell

@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation DHManagerTitleViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    
    return self;
}

-(void) initialize {
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.font = DHGDMainTitleViewItemDeSelectedFont;
    _titleLabel.textColor = DHGDMainTitleViewItemDeSelectedColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.contentView addSubview:_titleLabel];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

-(void)setSelected:(BOOL)selected {
    if(selected) {
        _titleLabel.textColor = DHGDMainTitleViewItemSelectedColor;
        _titleLabel.font = DHGDMainTitleViewItemSelectedFont;
        
    } else {
        _titleLabel.textColor = DHGDMainTitleViewItemDeSelectedColor;
        _titleLabel.font = DHGDMainTitleViewItemDeSelectedFont;
    }
}

@end

#define DHITEMHEIGHT 40

NSString *const DHManagerTitleViewCellIdentifier = @"DHManagerTitleViewCellIdentifier";

@interface DHManagerTitleView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) UIView *selectedLineView;

@end

@implementation DHManagerTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    frame = CGRectMake(0, 0, 150, DHITEMHEIGHT);
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(50, DHITEMHEIGHT);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[DHManagerTitleViewCell class] forCellWithReuseIdentifier:DHManagerTitleViewCellIdentifier];
    [self addSubview:_collectionView];
    
    _selectedLineView = [[UIView alloc] initWithFrame:CGRectMake(7, DHITEMHEIGHT, layout.itemSize.width - 14, 2)];
    _selectedLineView.backgroundColor = [UIColor blackColor];
    _selectedLineView.hidden = YES;
    [self addSubview:_selectedLineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
}

- (void)setIsShowIndicator:(BOOL)isShowIndicator {
    _isShowIndicator = isShowIndicator;
    _selectedLineView.hidden = !_isShowIndicator;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    [_collectionView reloadData];
    if(titles) {
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    
    if(_titles && currentIndex >= 0 && currentIndex < _titles.count) {
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        
        [self updateSelectedLineLayout];
    }
}

- (void)updateSelectedLineLayout {
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    CGRect rect = [self convertRect:cell.frame toView:self];
    __weak typeof (self) weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.selectedLineView.frame = CGRectMake(CGRectGetMinX(rect) + 7, CGRectGetMaxY(rect), CGRectGetWidth(rect) - 14, 2);
    }];
}

#pragma -mark collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(!_titles) {
        return 0;
    }
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DHManagerTitleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DHManagerTitleViewCellIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = _titles[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentIndex = indexPath.row;
    
    [self updateSelectedLineLayout];
    
    if(_delegate && [_delegate respondsToSelector:@selector(titleView:didSelectedAtIndex:)]) {
        [_delegate titleView:self didSelectedAtIndex:indexPath.row];
    }
}

@end
