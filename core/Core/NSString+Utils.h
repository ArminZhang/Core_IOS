//
//  NSString+Utils.h
//  字符串扩展功能
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 armin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Utils)

/**
 * 判断是否全是数字
 */
- (BOOL)isAllDigits;
/**
 *是否全是字母
 */
- (BOOL)isAllAlphaNumericCharacter;
/**
 *是否以数组开头
 */
- (BOOL)isStartWithDigit;

/**
 *十六进制颜色转UIColor
 */
- (UIColor *) toUIColor:(CGFloat)alpha;

@end
