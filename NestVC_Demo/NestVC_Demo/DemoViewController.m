//
//  DemoViewController.m
//  NestVC_Demo
//
//  Created by litianqi on 2017/9/6.
//  Copyright © 2017年 tqUDown. All rights reserved.
//

#import "DemoViewController.h"
#import "HomeCCell.h"
@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.switchViewButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(120);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- Nest_CollectionViewRefreshDelegate <NSObject>
- (void)headerRefreshEvent:(UICollectionView *)collection{
    [collection.mj_header endRefreshing];
}

- (void)footerRefreshEvent:(UICollectionView *)collection{
    [collection.mj_footer endRefreshing];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [HomeCCell size];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeCCell identifier] forIndexPath:indexPath];
    return  cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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
