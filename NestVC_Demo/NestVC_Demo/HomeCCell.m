//
//  HomeCCell.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/24.
//  Copyright © 2017年 UDown. All rights reserved.
//

#import "HomeCCell.h"

@implementation HomeCCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (HomeCCell *)homeCCell{
    return [[[UINib nibWithNibName:@"HomeCCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] firstObject];
}

+ (NSString *)identifier{
    return @"HomeCCellIdentifiter";
}

+ (CGSize)size{
    return CGSizeMake(167, 110);
}
@end
