//
//  GuideViewController.h
//  初次使用时的新手指引界面组件
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 armin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController
{
    BOOL _animating;
    
    UIScrollView *_pageScroll;
}

@property (nonatomic, assign) BOOL animating;

@property (nonatomic, strong) UIScrollView *pageScroll;

+ (GuideViewController *)sharedGuide;

+ (void)show:(NSArray *)imgArray enter:(UIButton *)enterButton;
+ (void)hide;

@end

