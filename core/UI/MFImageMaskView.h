//
//  MFImageMaskView.h
//  增加一个半透明遮罩层，并且在中间位置开一个方形孔，主要用于截图或者二维码扫描界面
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 armin. All rights reserved.
//
#ifndef MFImageMaskView_h
#define MFImageMaskView_h

#import <UIKit/UIKit.h>

@interface MFImageMaskView : UIView {
    @private
    CGRect  _cropRect;
    UIColor * _color;
}

- (void)setBorderColor:(UIColor *)color;

- (void)setCropSize:(CGSize)size;

- (CGSize)cropSize;

- (CGRect)getCropRect;

@end
#endif

