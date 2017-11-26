//
//  Nest_CollectionViewCell.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "Nest_CollectionViewCell.h"
#import "HomeCCell.h"
@interface Nest_CollectionViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign)BOOL isRigistered;
@end

@implementation Nest_CollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _subCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _subCollectionView.delegate = self.delegate;
        _subCollectionView.dataSource = self.delegate;
        [self.contentView addSubview:_subCollectionView];
        [_subCollectionView setBackgroundColor:[UIColor whiteColor]];
        _isRigistered = NO;
        
        
        _subCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _subCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        
        [_subCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView);
            make.trailing.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(44);
            make.bottom.equalTo(self.contentView);
        }];
        _delegate = nil;
    }
    return self;
}

- (void)requestData{
    if ([self.delegate respondsToSelector:@selector(headerRefreshEvent:)]) {
        [self.delegate headerRefreshEvent:_subCollectionView];
        return;
    }
    [_subCollectionView.mj_header endRefreshing];
}

- (void)loadMore{
    if ([self.delegate respondsToSelector:@selector(footerRefreshEvent:)]) {
        [self.delegate footerRefreshEvent:_subCollectionView];
        return;
    }
    [_subCollectionView.mj_footer endRefreshingWithNoMoreData];
}


- (void)setDelegate:(id)delegate{
    if (_delegate) {
        return;
    }
    _delegate = delegate;
    _subCollectionView.delegate = _delegate;
    _subCollectionView.dataSource = _delegate;
}

- (void)registerClassString:(NSString *)classString withCellIdentifiter:(NSString *)identifiter{
    if (_isRigistered) {
        return;
    }
    _isRigistered = YES;
//    NSString * file = [[NSBundle mainBundle] pathForResource:classString ofType:@".nib"];
    UINib *nib = [UINib nibWithNibName:classString bundle:[NSBundle mainBundle]];
    if (nib) {
         [self.subCollectionView registerNib:nib forCellWithReuseIdentifier:identifiter];
    }
    else{
        [self.subCollectionView registerClass:NSClassFromString(classString) forCellWithReuseIdentifier:identifiter];
    }
}
+ (NSString *)identifiter{
    return @"Nest_CollectionViewCell";
}
- (void)awakeFromNib{
    [super awakeFromNib];
}
@end
