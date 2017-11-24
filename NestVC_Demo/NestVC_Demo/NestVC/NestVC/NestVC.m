//
//  FreeCourseVC.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "NestVC.h"
#import "HomeCCell.h"
#import "Nest_CollectionViewCell.h"
@interface  CollectionViewDelegate: NSObject<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSArray * arrayItem;
@property (nonatomic, strong)NSString * cellIdentifiter;
@property (nonatomic, strong)NSString * classString;
@property (nonatomic, weak)NestVC * delegate;
@property (nonatomic, weak)UICollectionView * collection;
@end
@implementation CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayItem.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,self.delegate.view.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _collection = collectionView;
    Nest_CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[Nest_CollectionViewCell identifiter] forIndexPath:indexPath];
    
    [cell registerClassString:_classString withCellIdentifiter:_cellIdentifiter];
    [cell setDelegate:self.delegate];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint point  = *targetContentOffset;
    NSIndexPath * indexPath  = [_collection indexPathForItemAtPoint:point];
    NSLog(@"row =%ld",indexPath.row);
    self.delegate.switchViewButton.currentIndex = indexPath.row + 1;
}

@end


@interface NestVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SwitchViewButtonDelegate>
@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) NSArray * arrayItem;
@property (nonatomic, strong) NSString *  classCustom;
@property (nonatomic, strong) NSString *cellIdentifiter;
@property (nonatomic, strong) CollectionViewDelegate * collectionDelegate;

@end

@implementation NestVC
- (id)initWithSwitchItemArray:(NSArray *)arrayItem withClass:(NSString *)classCell withIdentifiter:(NSString *)cellIdentifiter{
    if (self = [super init]) {
        _arrayItem = arrayItem;
        _classCustom = classCell;
        _cellIdentifiter = cellIdentifiter;
    }
    return  self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _switchViewButton = [[SwitchViewButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,48)];
    _switchViewButton.arrayItem = _arrayItem;
    _switchViewButton.delegate = self;
    [self.view addSubview:_switchViewButton];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionDelegate = [CollectionViewDelegate new];
    _collectionDelegate.arrayItem = self.arrayItem;
    _collectionDelegate.cellIdentifiter = _cellIdentifiter;
    _collectionDelegate.classString = _classCustom;
    _collectionDelegate.delegate = self;
    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    _collection.delegate = _collectionDelegate;
    _collection.dataSource = _collectionDelegate;
    _collection.pagingEnabled = YES;
    _collection.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_collection];
    [_collection setBackgroundColor:[UIColor whiteColor]];
    [self.collection registerClass:[Nest_CollectionViewCell class] forCellWithReuseIdentifier:[Nest_CollectionViewCell identifiter]];
    
    [_switchViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(48));
    }];
    [_switchViewButton layoutIfNeeded];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.switchViewButton.mas_bottom).offset(5);
        make.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --SwitchBttonDelegate
- (void)clickButton:(NSInteger)index{
    NSLog(@"index = %ld",index);
    NSInteger row_to = index - 1;
    NSIndexPath * indexPathTo = [NSIndexPath indexPathForRow:row_to inSection:0];
    NSArray<NSIndexPath *> * array = _collection.indexPathsForVisibleItems;
    
    if (!array || array.count == 0) {
        [_collection scrollToItemAtIndexPath:indexPathTo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        return;
    }
    NSIndexPath * indexPath = array.firstObject;
    NSInteger row_now = indexPath.row;
    if (labs(row_to - row_now) >= 2) {
        if ((row_to - row_now) > 0) {
            row_now = row_to;
            row_now--;
        }
        else{
            row_now = row_to;
            row_now++;
        }
        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row_now inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    [_collection scrollToItemAtIndexPath:indexPathTo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
