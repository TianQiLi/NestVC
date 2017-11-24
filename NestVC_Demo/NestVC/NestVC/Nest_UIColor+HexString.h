//
//  UIColor+HexString.h
//  NestVC
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 UDown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexStringNest)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

@end
