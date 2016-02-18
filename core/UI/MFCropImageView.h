//
//  MFCropImageView.h
//  截图组件
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 armin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFImageMaskView.h"

@interface MFCropImageView : UIView <UIScrollViewDelegate> {
    @private
    UIScrollView        *_scrollView;
    UIImageView         *_imageView;
    MFImageMaskView     *_maskView;
    UIImage             *_image;
    UIEdgeInsets        _imageInset;
    CGSize              _cropSize;
}

- (void)setImage:(UIImage *)image;
- (void)setCropSize:(CGSize)size;

- (UIImage *)cropImage;

@end

