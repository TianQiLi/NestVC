//
//  Nest_CollectionViewCell.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "Nest_CollectionViewCell.h"
NSString * const CellSelectedNotification = @"CellSelectedNotification";
@implementation Nest_CollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pageForIndex = @{}.mutableCopy;
        _dataForRowArray = @{}.mutableCopy;
        _paraDic = @{}.mutableCopy;
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setMinimumInteritemSpacing:0.0f];
        [flowLayout setMinimumLineSpacing:0.0f];
        [flowLayout setSectionInset:UIEdgeInsetsZero];
        _subCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300) collectionViewLayout:flowLayout];
        [_subCollectionView setBackgroundColor:[UIColor colorWithHexString:@"0xffffff"]];
        _subCollectionView.delegate = self;
        _subCollectionView.dataSource = self;
        [self addSubview:_subCollectionView];
        [_subCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.top.equalTo(self);//44
            make.bottom.equalTo(self);
        }];
        

    }
    return self;
}

- (NSInteger)currentSwitchBtnIndex{
    return _currentVC.currentSwitchBtnIndex;
}

+ (NSString *)cellIdentifiter{
    return  @"Nest_CollectionViewCellIdentif";
}

@end
