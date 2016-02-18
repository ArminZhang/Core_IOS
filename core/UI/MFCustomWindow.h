//
//  MFCustomWindow.h
//  自定义弹出窗口组件
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 armin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WindowLocationType) {
    WindowLocationTypeDefault = 0,
    WindowLocationTypeDown
};

@class MFCustomWindow;
typedef void(^clickWithIndex)(NSInteger index);

@interface MFCustomWindow : UIWindow{
    UIButton *backgroundView;
    UIView *contentView;
    UIImageView *backgroundImage;
    BOOL closed;
}

+ (id)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                dismissInBackgroud:(BOOL)dismissInBackgroud
                             Click:(clickWithIndex)click;

+ (id)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                      confirmTitle:(NSString *)confirmTitle
                dismissInBackgroud:(BOOL)dismissInBackgroud
                             Click:(clickWithIndex)click;

- (id)initWithView:(UIView *)aView
dismissInBackgroud:(BOOL)dismissInBackgroud
      locationType:(WindowLocationType)locationType;

- (void)show;

- (void)dismiss;

@end
