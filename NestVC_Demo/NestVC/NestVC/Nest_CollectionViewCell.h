//
//  Nest_CollectionViewCell.h
//  NestVC
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 UDown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import <Masonry.h>

@protocol Nest_CollectionViewRefreshDelegate <NSObject>
- (void)headerRefreshEvent:(UICollectionView *)collectionView;
- (void)footerRefreshEvent:(UICollectionView *)collectionView;

@end

@interface Nest_CollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong)UICollectionView * subCollectionView;
/** delegate */
@property (nonatomic, weak) id<Nest_CollectionViewRefreshDelegate> delegate;
/** id */
- (void)setDelegate:(id)delegate;
- (void)registerClassString:(NSString *)classString withCellIdentifiter:(NSString *)identifiter;

+ (NSString *)identifiter;
@end
