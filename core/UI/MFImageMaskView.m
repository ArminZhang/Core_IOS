//
//  MFImageMaskView.m
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 armin. All rights reserved.
//

#import "MFImageMaskView.h"

#define kMaskViewBorderWidth 1.0f

@implementation MFImageMaskView

- (void)setBorderColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setCropSize:(CGSize)size {
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    
    [self setNeedsDisplay];
}

- (CGSize)cropSize {
    return _cropRect.size;
}

- (CGRect)getCropRect {
    return _cropRect;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 205, 205, 205, .8);
    CGContextFillRect(ctx, self.bounds);
    
    CGContextSetStrokeColorWithColor(ctx, _color.CGColor);
    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
    
    CGContextClearRect(ctx, _cropRect);
}
@end

