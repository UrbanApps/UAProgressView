//
//  UAProgressView.h
//  UAProgressView-Example
//
//  Created by Matt Coneybeare on 5/25/14.
//  Copyright (c) 2014 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UAProgressView : UIView <CAAnimationDelegate>

/**
 *  Called when the progress view is filled with tintColor, or removed
 *
 *  Example usage would be to invert the colors on your centralView
 */
@property (nonatomic, copy) void (^fillChangedBlock)(UAProgressView *progressView, BOOL filled, BOOL animated);

/**
 *  Called on touchUpInside
 *
 *  Example usage would be to invert the colors on your centralView
 */
@property (nonatomic, copy) void (^didSelectBlock)(UAProgressView *progressView);

/**
 *  Called on setProgress
 *
 *  Example usage would be to update any central view labels
 */
@property (nonatomic, copy) void (^progressChangedBlock)(UAProgressView *progressView, CGFloat progress);

/**
 *  The view in the center of the progress view.
 *
 *  It will be centered in the view but not resized, so plan accordingly
 *
 *  Can be set to anything you want though, a label with the progress %, a stop button etc...
 *  Sits above the progressView in the layer heirarchy so it receives first tap.
 *
 *  Defaults to nil.
 */
@property (nonatomic, strong) UIView *centralView;

/**
 * Fills in the circle with the tintColor on touch.
 *
 * Fills immediately, but fades when touch removed.
 *
 * Default is YES.
 */
@property (nonatomic, assign) BOOL fillOnTouch UI_APPEARANCE_SELECTOR;

/**
 * The line width of the outer circle
 *
 * Default is 1.0.
 */
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

/**
 * The line width of the inner circle
 *
 * Default is 2.0.
 */
@property (nonatomic, assign) CGFloat lineWidth UI_APPEARANCE_SELECTOR;

/**
 * The color of the stroke and border
 *
 * Defaults to #007aff
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 * The color of the fill contents
 *
 * Defaults to same tintColor
 */
@property (nonatomic, strong) UIColor *fillColor;

/**
 *  Gets/sets the progress, from 0.0 to 1.0. Progress < 0 is set to 0.0, progress > 1 is set to 1.0
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  The duration over which to animate the progress set. Default is 0.3 seconds. animationDuration < 0 is ignored
 */
@property (nonatomic, assign) CFTimeInterval animationDuration UI_APPEARANCE_SELECTOR;

/**
 *  Changes progress animated.
 *
 *  Progress < 0 is set to 0.0, progress > 1 is set to 1.0
 *  The animation will be always linear.
 *
 *  @param progress The new progress value.
 *  @param animated Specify YES to animate the change or NO if you do not want the change to be animated.
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

/**
 *  Fill contents.
 */
- (void)addFill;

/**
 *  The long press gesture that is used to recognize single taps and long presses on the central
 *  view.
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *gestureRecognizer;

/**
 *  Specify an optional long press duration that will fire the didLongPressBlock when reached.
 *  Must be > 0.0.
 *
 *  Default is 0.0 (disabled).
 */
@property (nonatomic, assign) CGFloat longPressDuration;

/**
 * Cancels the selection when the long press duration is reached.
 *
 * Default is NO.
 */
@property (nonatomic, assign) BOOL longPressCancelsSelect;

/**
 *  Called on when the longPressDuration has been reached.
 *
 *  Example usage would be to reset the progress.
 */
@property (nonatomic, copy) void (^didLongPressBlock)(UAProgressView *progressView);

@end
