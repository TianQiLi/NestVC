//
//  Free_CourseVC.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

/**
 * 子类继承Nest_CollectionViewCell ,重写cell的协议方法就可以
 */

#import "Nest_CollectionViewCell.h"
extern NSString * const SwitchBttonClickNotification;
@interface Free_CourseVC : Nest_CollectionViewCell
@property (nonatomic, assign) NSInteger examId;
+ (NSString *)cellIdentifiter;
@end
