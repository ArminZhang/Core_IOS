//
//  MFCustomWindow.m
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 armin. All rights reserved.
//

#import "MFCustomWindow.h"
#import "UIImage+Utils.h"
#import "MFLayout.h"
#import "UIView+Utils.h"
#import "NSString+Utils.h"
#import <objc/runtime.h>

#define iOS7OrLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define MFColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

@implementation MFCustomWindow

static char overviewKey;

- (id)initWithView:(UIView *)aView
dismissInBackgroud:(BOOL)dismissInBackgroud
      locationType:(WindowLocationType)locationType
{
    
    if (self=[super init]) {
        //初始化主屏幕
        [self setFrame:[[UIScreen mainScreen]bounds]];
        self.windowLevel =UIWindowLevelStatusBar;
        contentView = aView;
        
        //屏幕截图并模糊处理
        UIWindow *screenWindow = [UIApplication sharedApplication].windows.firstObject;
        UIGraphicsBeginImageContext(screenWindow.frame.size);
        [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *originalImage = nil;
        if (iOS7OrLater) {
            originalImage = viewImage;
        } else {
            originalImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(viewImage.CGImage, CGRectMake(0, 20, 320, 460))];
        }
        
        backgroundImage = [[UIImageView alloc]initWithImage:[originalImage gaussBlur:0.1 boxSize : 10]];
        [backgroundImage setFrame:self.bounds];
        [self addSubview:backgroundImage];
        
        int c_x = (self.bounds.size.width - contentView.bounds.size.width)/2;
        int c_y = (self.bounds.size.height - contentView.bounds.size.height)/2;
        if(locationType == WindowLocationTypeDown)
            c_y = self.bounds.size.height - contentView.bounds.size.height;
        
        //设置背景视图
        backgroundView = [[UIButton alloc]initWithFrame:self.bounds];
        [self addSubview:backgroundView];
        backgroundView.alpha = 0;
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        [backgroundView addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];

        //显示内容view
        CGRect frame =CGRectMake(c_x, c_y, contentView.bounds.size.width, contentView.bounds.size.height);
        [contentView setFrame:frame];
        [backgroundView addSubview:contentView];
        
        closed =NO;
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
        [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

-(void)closeAction:(id)sender{
    [self dismiss];
}

- (void)keyboardWillShown:(NSNotification*)notification
{
    if(closed){
        CGRect keyboardFrameBeginRect = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    if(closed)
    {
        
    }
}

//显示弹出窗口
-(void)show {
    CGFloat duration = 0.3;
    self.windowLevel = UIWindowLevelNormal;
    [self makeKeyAndVisible];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         backgroundView.alpha = 1;
                     }
                     completion:NULL];
    
    if (iOS7OrLater) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
        animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        animation.duration = duration;
        [contentView.layer addAnimation:animation forKey:@"bouce"];
    } else {
        contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        [UIView animateWithDuration:duration * 0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            contentView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration * 0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration * 0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    contentView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:nil];
            }];
        }];
    }
    closed = NO;
}

//关闭弹出窗口
-(void)dismiss {
    closed = YES;
    
    [backgroundView removeFromSuperview];
    backgroundView =nil;
    
    [self setAlpha:0.0f];
    [self removeFromSuperview];
}

/**
 * 显示一个提示窗口，带图片关闭按钮
 */
+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
      dismissInBackgroud:(BOOL)dismissInBackgroud
                   Click:(clickWithIndex)click
{
    CGFloat width = [[UIScreen mainScreen]bounds].size.width - 2*40;
    CGRect frame = CGRectMake(0,0, width, 100);
    UIView *bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [@"#F6F6F6" toUIColor:1];
    MFLayout *layout = [[MFLayout alloc]initWithWiew:bgView];
    
    UILabel *titleView = [[UILabel alloc]init];
    [titleView setText:title];
    titleView.font = [UIFont boldSystemFontOfSize:14];
    titleView.textColor = [@"#1C1C1C" toUIColor:1];
    MFLayoutParam *param = [[MFLayoutParam alloc]init:titleView left:20 top:0 right:20 bottom:0 width:MatchParent height:44];
    [layout AddViewRow:param horizontalType:ViewHorizontalTypeCenter];
    [titleView addBottomBorderWithColor:@"#D3D3D3" andWidth:1];
    
    UILabel *contextView = [[UILabel alloc]init];
    [contextView setText:message];
    contextView.numberOfLines = 0;
    contextView.lineBreakMode = NSLineBreakByWordWrapping;
    contextView.font = [UIFont systemFontOfSize:14];
    contextView.textColor = [@"#656565" toUIColor:1];
    CGSize size = [contextView sizeThatFits:CGSizeMake(contextView.frame.size.width, MAXFLOAT)];
    param = [[MFLayoutParam alloc]init:contextView left:20 top:10 right:20 bottom:10 width:MatchParent height:60];
    [layout AddViewRow:param horizontalType:ViewHorizontalTypeCenter];
    
    UIButton *btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_close setImage:[UIImage imageNamed:@"core.bundle/dialog_close"] forState:UIControlStateNormal];
    btn_close.tag = 0;
    param = [[MFLayoutParam alloc]init:btn_close margin:5 width:44 height:44];
    [layout AddViewRow:param horizontalType:ViewHorizontalTypeCenter];
    
    [bgView setFrame:CGRectMake(0, 0, width, [layout getHeight])];
    MFCustomWindow *alertwindow = [[MFCustomWindow alloc]initWithView:bgView
                                                   dismissInBackgroud:YES
                                                         locationType:WindowLocationTypeDefault];
    
    objc_setAssociatedObject(btn_close, &overviewKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [btn_close addTarget:alertwindow action:@selector(blockAction:) forControlEvents:UIControlEventTouchUpInside];
    return alertwindow;
}

/**
 *
 */
+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
             cancelTitle:(NSString *)cancelTitle
            confirmTitle:(NSString *)confirmTitle
      dismissInBackgroud:(BOOL)dismissInBackgroud
                   Click:(clickWithIndex)click
{
    return nil;
}

-(void)blockAction:(id)sender{
    clickWithIndex block = (clickWithIndex)objc_getAssociatedObject(sender, &overviewKey);
    if (block) {
        block([sender tag]);
    }
}


@end
