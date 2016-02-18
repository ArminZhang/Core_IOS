//
//  UIView+Border.h
//  给UIView加上边框，并且可以单独设置各个边框的颜色
//
//  Created by apple on 15/12/20.
//  Copyright © 2015年 armin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

/**
 * Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat screenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat screenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 Attaches the given block for a single tap action to the receiver.
 @param block The block to execute.
 */
- (void)setTapActionWithBlock:(void (^)(void))block;

/**
 Attaches the given block for a long press action to the receiver.
 @param block The block to execute.
 */
- (void)setBorder:(CGFloat)left
              top:(CGFloat)top
            right:(CGFloat)right
           bottom:(CGFloat)bottom
            color:(NSString *)color
            width:(CGFloat)width;

- (void)setLongPressActionWithBlock:(void (^)(void))block;

- (void)addTopBorderWithColor:(NSString *)color andWidth:(CGFloat) borderWidth;

- (void)addBottomBorderWithColor:(NSString *)color andWidth:(CGFloat) borderWidth;

- (void)addLeftBorderWithColor:(NSString *)color andWidth:(CGFloat) borderWidth;

- (void)addRightBorderWithColor:(NSString *)color andWidth:(CGFloat) borderWidth;

@end

@interface BorderLayer : CALayer

@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, assign) CGFloat topWidth;
@property (nonatomic, assign) CGFloat rightWidth;
@property (nonatomic, assign) CGFloat bottomWidth;

@property (nonatomic, copy) UIColor *leftColor;
@property (nonatomic, copy) UIColor *topColor;
@property (nonatomic, copy) UIColor *rightColor;
@property (nonatomic, copy) UIColor *bottomColor;

@end
