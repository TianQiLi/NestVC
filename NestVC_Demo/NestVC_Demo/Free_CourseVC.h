//
//  Free_CourseVC.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "Nest_CollectionViewCell.h"
extern NSString * const SwitchBttonClickNotification;
@interface Free_CourseVC : Nest_CollectionViewCell
@property (nonatomic, assign) NSInteger examId;
+ (NSString *)cellIdentifiter;
@end
