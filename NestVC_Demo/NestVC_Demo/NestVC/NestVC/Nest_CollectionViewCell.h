//
//  Nest_CollectionViewCell.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
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
//@property (nonatomic, weak) UIViewController * currentVC;
- (void)setDelegate:(id)delegate;
- (void)registerClassString:(NSString *)classString withCellIdentifiter:(NSString *)identifiter;

+ (NSString *)identifiter;
@end
