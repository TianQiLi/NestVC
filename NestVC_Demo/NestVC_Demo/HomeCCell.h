//
//  HomeCCell.h
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/24.
//  Copyright © 2017年 UDown. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeCCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *courseTitle;
+ (HomeCCell *)homeCCell;
+ (NSString *)identifier;
+ (CGSize)size;
@end
