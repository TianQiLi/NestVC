//
//  FreeCourseVC.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "NestVC.h"
//#import "CommonTextCCell.h"
//#import "CommonSectionCellHeader.h"
#import "Nest_CollectionViewCell.h"
#import "SwitchViewButton.h"

NSString * const SwitchBttonClickNotification = @"SwitchBttonClickNotification";
@interface NestVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SwitchViewButtonDelegate>
@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) SwitchViewButton * switchViewButton;
@property (nonatomic, strong) NSArray * arrayItem;
//@property (nonatomic, strong) NSString *  classCustom;
@property (nonatomic, strong) NSArray *  classCustomArray;
//@property (nonatomic, strong) NSString *cellIdentifiter;
@property (nonatomic, strong) NSArray *cellIdentifiterArray;

@property (nonatomic, strong) NSMutableDictionary *dataForRowArray;
@property (nonatomic, strong) NSMutableDictionary *pageForIndex;
@property (nonatomic, assign) NSInteger bottomMargin;//button & cell
@property (nonatomic, assign) NSInteger currentSwitchBtnIndex;//1...n
@end

@implementation NestVC

- (NSInteger)currentSwitchBtnIndex{
    return _currentSwitchBtnIndex;
}

- (id)initWithSwitchItemArray:(NSArray *)arrayItem withClassArray:(NSArray *)classCellArray withIdentifiter:(NSArray *)cellIdentiArray{
    if (self = [super init]) {
        _arrayItem = arrayItem;
        _classCustomArray = classCellArray;
        _cellIdentifiterArray = cellIdentiArray;
        _bottomMargin = 10;//default
        _currentSwitchBtnIndex = 1;
    }
    return  self;
    
}

- (id)initWithSwitchItemArray:(NSArray *)arrayItem withDelegate:(id)obj{
    if (self = [super init]) {
        _arrayItem = arrayItem;
        
    }
    return  self;
}

- (void)setSwitchButtonBottomMargin:(NSInteger)bottomMargin{
    _bottomMargin = bottomMargin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0xf4f4f4"]];
    _dataForRowArray = [NSMutableDictionary new];
    _pageForIndex = [NSMutableDictionary new];
    _switchViewButton = [[SwitchViewButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,48)];
    _switchViewButton.arrayItem = _arrayItem;
    _switchViewButton.delegate = self;
     [_switchViewButton setBackgroundColor:[UIColor whiteColor]];
     [self.view addSubview:_switchViewButton];
     [_switchViewButton hiddenBottomLine:YES];
    
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setSectionInset:UIEdgeInsetsZero];

    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    _collection.showsVerticalScrollIndicator = NO;
    [_collection setBackgroundColor:[UIColor colorWithHexString:@"0xffffff"]];
    [self.view addSubview:_collection];
  
    for (NSInteger i = 0 ; i< self.arrayItem.count ; i++) {
        if (i >= self.classCustomArray.count) {
            continue;
        }
        NSString * classCustom = self.classCustomArray[i];
        NSString * cellIdentif = self.cellIdentifiterArray[i];
        [self.collection registerClass:NSClassFromString(classCustom) forCellWithReuseIdentifier:cellIdentif];
    
    }
    
    [_switchViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@(48));
    }];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.switchViewButton.mas_bottom).offset(_bottomMargin);
        make.bottom.equalTo(self.view);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLayoutCollectionView:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)reLayoutCollectionView:(NSNotification *)notification {
//    _collection. itemSize = CGSizeMake(self.collection.bounds.size.width, self.collection.bounds.size.height);
//    [self.collection reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayItem.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width, self.collection.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString * cellIdentifiter = @"";
    if (indexPath.row < self.cellIdentifiterArray.count) {
         cellIdentifiter = self.cellIdentifiterArray[indexPath.row];
    }else{
        cellIdentifiter = (self.cellIdentifiterArray.count >0) ? self.cellIdentifiterArray[0] : @"cell";
    }
    
    Nest_CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifiter forIndexPath:indexPath];
    cell.paraDic = self.paramaterDic;
//    cell.currentSwitchBtnIndex = self.currentSwitchBtnIndex;
    cell.row = indexPath.row;//override
    cell.currentVC = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    DDLogInfo(@"testrow=%ld\n",indexPath.row);
    Nest_CollectionViewCell * cellNew = (Nest_CollectionViewCell *)cell;
    NSNumber * page = self.pageForIndex[@(indexPath.row)];
    cellNew.page = page? [page integerValue] : 1;
    
    cellNew.pageForIndex = self.pageForIndex;
    cellNew.dataForRowArray = self.dataForRowArray;
    cellNew.row = indexPath.row;//override
    

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint point  = *targetContentOffset;
    NSIndexPath * indexPath = [self.collection indexPathForItemAtPoint:point];
//    DDLogInfo(@"scrollView row =%ld",indexPath.row);
    _currentSwitchBtnIndex = indexPath.row + 1;
    self.switchViewButton.currentIndex = _currentSwitchBtnIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --SwitchBttonDelegate
- (void)clickButton:(NSInteger)index{
    _currentSwitchBtnIndex = index;
    [self staticsCourseType:index];
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
//        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row_now inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    [_collection scrollToItemAtIndexPath:indexPathTo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:SwitchBttonClickNotification object:@(_currentSwitchBtnIndex)];
}


- (void)staticsCourseType:(NSInteger)index{
    
}

- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex{
    _switchViewButton.currentIndex = switchBtnIndex;
    [self clickButton:_switchViewButton.currentIndex];
    
}

//#pragma mark --Nest_CollectionViewCellDelegate
//- (void)scrollViewCurrentIndexPath:(NSIndexPath *)indexPath{
//    DDLogInfo(@"row1 = %ld\n",indexPath.row);
//    self.switchViewButton.currentIndex = indexPath.row;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
