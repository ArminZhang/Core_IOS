//
//  GuideViewController.m
//  初次使用时的新手指引界面组件
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 armin. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

@synthesize animating = _animating;

@synthesize pageScroll = _pageScroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -

- (CGRect)onscreenFrame
{
    return [UIScreen mainScreen].applicationFrame;
}

- (CGRect)offscreenFrame
{
    CGRect frame = [self onscreenFrame];
    switch ([UIApplication sharedApplication].statusBarOrientation)
    {
        case UIInterfaceOrientationPortrait:
            frame.origin.y = frame.size.height;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            frame.origin.y = -frame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            frame.origin.x = frame.size.width;
            break;
        case UIInterfaceOrientationLandscapeRight:
            frame.origin.x = -frame.size.width;
            break;
    }
    return frame;
}

- (void)showGuide
{
    if (!_animating && self.view.superview == nil)
    {
        [GuideViewController sharedGuide].view.frame = [self offscreenFrame];
        [[self mainWindow] addSubview:[GuideViewController sharedGuide].view];
        
        _animating = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(guideShown)];
        [GuideViewController sharedGuide].view.frame = [self onscreenFrame];
        [UIView commitAnimations];
    }
}

- (void)guideShown
{
    _animating = NO;
}

- (void)hideGuide
{
    if (!_animating && self.view.superview != nil)
    {
        _animating = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(guideHidden)];
        [GuideViewController sharedGuide].view.frame = [self offscreenFrame];
        [UIView commitAnimations];
    }
}

- (void)guideHidden
{
    _animating = NO;
    [[[GuideViewController sharedGuide] view] removeFromSuperview];
}

- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

+ (void)show:(NSArray *)imgArray enter:(UIButton *)enterButton
{
    GuideViewController *guide = [GuideViewController sharedGuide];
    [guide.pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
    [guide initView:imgArray enter:enterButton];
    [guide showGuide];
}

+ (void)hide
{
    [[GuideViewController sharedGuide] hideGuide];
}

#pragma mark -

+ (GuideViewController *)sharedGuide
{
    @synchronized(self)
    {
        static GuideViewController *sharedGuide = nil;
        if (sharedGuide == nil)
        {
            sharedGuide = [[self alloc] init];
        }
        return sharedGuide;
    }
}

- (void)pressCheckButton:(UIButton *)checkButton
{
    [checkButton setSelected:!checkButton.selected];
}

- (void)pressEnterButton:(UIButton *)enterButton
{
    [self hideGuide];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)initView:(NSArray *)imgArray enter:(UIButton *)enterButton {
    self.pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imgArray.count, 0);
    
    NSString *imgName = nil;
    UIView *view;
    for (int i = 0; i < imgArray.count; i++) {
        imgName = [imgArray objectAtIndex:i];
        view = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width * i), 0.f, self.view.frame.size.width, self.view.frame.size.height)];
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imgName]];
        [self.pageScroll addSubview:view];
        
        if (i == imgArray.count - 1) {
            [enterButton addTarget:self action:@selector(pressEnterButton:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:enterButton];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.pageScroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
