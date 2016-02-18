//
//  LaunchViewController.m
//  启动页面组件

//  四种setModalTransitionStyle风格:
//    UIModalTransitionStyleCoverVertical 从底部滑入
//    UIModalTransitionStyleFlipHorizontal,水平翻转进入
//    UIModalTransitionStyleCrossDissolve,交叉溶解
//    UIModalTransitionStylePartialCurl,翻页
//  Created by apple on 16/1/8.
//  Copyright © 2016年 armin. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition delay:(NSTimeInterval)seconds {
    self = [super init];
    
    if (self) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *launchImageFile = [infoDictionary objectForKey:@"UILaunchImageFile"];
        
        NSString *launchImageFileiPhone = [infoDictionary objectForKey:@"UILaunchImageFile~iphone"];
        
        if (launchImageFile != nil) {
            [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImageFile]]];
        } else if (launchImageFileiPhone != nil) {
            [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImageFileiPhone]]];
        } else {
            [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]]];
        }
        
        [controller setModalTransitionStyle:transition];
        
        [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(timerFireMethod:) userInfo:controller repeats:NO];
    }
    
    return self;
}

- (void)timerFireMethod:(NSTimer *)theTimer {
    [self presentModalViewController:[theTimer userInfo] animated:YES];
}

@end
