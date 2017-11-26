//
//  Nest_CollectionViewCell.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol Nest_CollectionViewCellDelegate <NSObject>
//
//- (void)scrollViewCurrentIndexPath:(NSIndexPath *)indexPath;
//
//@end
extern NSString * const SwitchBttonClickNotification;
extern NSString * const CellSelectedNotification;
#import "NestVC.h"
@interface Nest_CollectionViewCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (readonly)UICollectionView * subCollectionView;
/** para */
@property (nonatomic, strong) NSDictionary *paraDic;
/** id */
@property (nonatomic, weak) NestVC * currentVC;
@property (nonatomic, strong) NSMutableDictionary *dataForRowArray;
@property (nonatomic, strong) NSMutableDictionary *pageForIndex;
/** row */
@property (nonatomic, assign) NSInteger row;//in superCollection
@property (nonatomic, assign) NSInteger page;//1...n
@property (nonatomic, assign,readonly) NSInteger currentSwitchBtnIndex;//1...n
+ (NSString *)cellIdentifiter;

@end
