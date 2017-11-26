//
//  Free_CourseVC.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "Free_CourseVC.h"
#import "HomeCCell.h"
@interface Free_CourseVC()
@property (nonatomic, assign) NSInteger type;//2 :口语, 3: 听力,  4 :阅读, 5:写作
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) NSInteger requestOk;

@end

@implementation Free_CourseVC
+ (NSString *)cellIdentifiter{
    return @"Free_CourseVCIdentifi";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SwitchBttonClickNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.page = 1;
        self.subCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        [self setFooter];
        [self.subCollectionView registerNib:[UINib nibWithNibName:@"HomeCCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[HomeCCell identifier]];
        
        NSArray * typeArray = [self getTypeArray];
        _type = [typeArray[0] integerValue];
        _requestOk = YES;
        [self.subCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(44);//44
            
        }];
    }
    return self;
}

- (void)setRow:(NSInteger)row{
    [super setRow:row];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = self.dataForRowArray[@(self.row)];
        if (self.dataArray.count == 0) {
            [self.subCollectionView.mj_header beginRefreshing];
        }
        else{
//            self.dataArray = self.dataForRowArray[@(self.row)];
            self.requestOk = YES;
            [self.subCollectionView reloadData];
        }

    });

}

- (void)setFooter{
    self.subCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (NSArray *)getTypeArray{
    return @[@(2),@(3),@(4),@(5)];
}

- (void)requestData{
     [self setFooter];
     self.requestOk = YES;
    //TODO: load data
    NSInteger examId = (self.paraDic && self.paraDic[@"examId"]) ? [self.paraDic[@"examId"] integerValue] : 0;
    _examId = examId;
    NSArray * array = [self getTypeArray];
    _type = [array[self.row] integerValue];

    [self handleResults:@[@"1",@"2"] withStatus:YES];
//    [FreeRecord_CourseManager queryFRCourseListWithExamId:_examId type:_type withPage:self.page limit:8 success:^(NSArray<FreeRecord_CourseModel *> *results) {
//        [self handleResults:results withStatus:YES];
//    } failure:^(NSError *error) {
//        [self handleResults:@[] withStatus:NO];
//    }];
}

- (void)loadData{
    self.page = 1;
    [self requestData];
}

- (void)loadMore{
    self.page++;
    [self requestData];
}

- (void)handleResults:(NSArray *)results withStatus:(BOOL)successed{
    if (self.page == 1 && !successed) {
        self.requestOk = NO;
        self.dataArray = @[];
        [self.subCollectionView.mj_header endRefreshing];
        [self.subCollectionView.mj_footer endRefreshingWithNoMoreData];
        [self.subCollectionView reloadData];
        self.subCollectionView.mj_footer = nil;
        return;
    }
    
    if (self.page == 1) {
        self.dataArray = results;
    }
    else{
        NSMutableArray * arrayNew = [NSMutableArray new];
        [arrayNew addObjectsFromArray:self.dataArray];
        [arrayNew addObjectsFromArray:results];
        self.dataArray = arrayNew.copy;
    }
    if (self.page == 1 && results.count == 0) {
        self.subCollectionView.mj_footer.alpha = 0;
    }
    else{
        self.subCollectionView.mj_footer.alpha = 1;
    }
    
    if (self.page == 1 && results.count < 8) {
        [self.subCollectionView.mj_header endRefreshing];
        [self.subCollectionView.mj_footer endRefreshingWithNoMoreData];
    }
    else if(self.page == 1 && results.count == 8){
        [self.subCollectionView.mj_header endRefreshing];
        [self.subCollectionView.mj_footer endRefreshing];
    }
    else if(results.count < 8){
        [self.subCollectionView.mj_footer endRefreshingWithNoMoreData];
    }
    else{
         [self.subCollectionView.mj_footer endRefreshing];
    }
    
    [self.dataForRowArray setObject:self.dataArray forKey:@(self.row)];
    [self.pageForIndex setObject:@(self.page) forKey:@(self.row)];
    [self.subCollectionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return (self.dataArray && self.dataArray.count > 0) ? self.dataArray.count : 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.dataArray || self.dataArray.count == 0) {
        return CGSizeMake(self.frame.size.width, self.subCollectionView.frame.size.height-60);
    }
    return [HomeCCell size];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    if (!self.dataArray || self.dataArray.count == 0) {
 
    }
    
    HomeCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeCCell identifier] forIndexPath:indexPath];

    return  cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
  
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
}

@end
