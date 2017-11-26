//
//  FreeCourseVC.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchViewButton.h"
#import <MJRefresh.h>
#import <Masonry.h>

@interface NestVC : UIViewController
@property (nonatomic, strong) SwitchViewButton * switchViewButton;
- (id)initWithSwitchItemArray:(NSArray *)arrayItem withClass:(NSString *)classCell withIdentifiter:(NSString *)cellIdentifiter;
@end
