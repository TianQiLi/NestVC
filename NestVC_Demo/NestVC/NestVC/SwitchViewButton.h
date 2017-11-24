//
//  SwitchViewButton.h
//  NestVC
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 UDown. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchViewButtonDelegate <NSObject>
- (void)clickButton:(NSInteger)index;//1...n
@end

@interface SwitchViewButton : UIView
@property (nonatomic, strong)NSArray * arrayItem;
@property (nonatomic, assign)NSInteger currentIndex;//默认1: 1...n
@property (weak ,nonatomic) id<SwitchViewButtonDelegate>delegate;
+ (CGSize)contentSize;
@end


//@protocol SwitchViewButtonCollectionCellDelegate <NSObject>
//-(void)clickCellItem:(NSInteger)indexItem;
//
//@end

@interface SwitchViewButtonCollectionCell : UICollectionViewCell<SwitchViewButtonDelegate>
@property (nonatomic, strong) SwitchViewButton * swithchViewbutton;
@property (nonatomic, weak) id<SwitchViewButtonDelegate> delegate;

@end


@interface SwitchViewButtonCollectionReusableViewCell : UICollectionReusableView<SwitchViewButtonDelegate>
@property (nonatomic, strong) SwitchViewButton * swithchViewbutton;
@property (nonatomic, weak) id<SwitchViewButtonDelegate> delegate;
@property (nonatomic, assign) NSInteger currentIndex;


@end
