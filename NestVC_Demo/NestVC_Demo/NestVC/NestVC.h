//
//  FreeCourseVC.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const SwitchBttonClickNotification;
@interface NestVC : UIViewController
/** paramater */
@property (nonatomic, strong) NSDictionary *paramaterDic;
- (id)initWithSwitchItemArray:(NSArray *)arrayItem withDelegate:(id)obj;
- (id)initWithSwitchItemArray:(NSArray *)arrayItem withClassArray:(NSArray *)classCellArray withIdentifiter:(NSArray *)cellIdentiArray;

- (void)setSwitchButtonBottomMargin:(NSInteger)bottomMargin;
- (void)staticsCourseType:(NSInteger)index;

- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex;
- (NSInteger)currentSwitchBtnIndex;
@end
