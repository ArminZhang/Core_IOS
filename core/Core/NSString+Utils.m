//
//  NSString+Utils.m
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 armin. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)isAllDigits
{
    NSCharacterSet *nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:nonNumbers];
    return range.location == NSNotFound;
}

- (BOOL)isAllAlphaNumericCharacter
{
    NSCharacterSet *nonNumbers = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:nonNumbers];
    return range.location == NSNotFound;
}

- (BOOL)isStartWithDigit
{
    NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
    NSRange range = [self rangeOfCharacterFromSet:numbers];
    
    return range.location == 0;
}

- (UIColor *)toUIColor:(CGFloat)alpha
{
    if (!self || [self isEqualToString:@""]) {
        return [UIColor whiteColor];
    }
    
    unsigned int c;
    if ([self characterAtIndex:0] == '#') {
        [[NSScanner scannerWithString:[self substringFromIndex:1]] scanHexInt:&c];
    } else {
        [[NSScanner scannerWithString:self] scanHexInt:&c];
    }
    return [UIColor colorWithRed:((c & 0xff0000) >> 16)/255.0f green:((c & 0xff00) >> 8)/255.0f blue:(c & 0xff)/255.0f alpha:alpha];
}

@end
