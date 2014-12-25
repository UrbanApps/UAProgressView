UAProgressView is a simple and lightweight, yet powerful animated circular progress view.

![UAProgressView](https://raw.githubusercontent.com/UrbanApps/UAProgressView/assets/UAProgressView.gif "Example 1")

## Installation

Installation is made simple with [Cocoapods](http://cocoapods.org/). If you want to do it the old fashioned way, just add `UAProgressView.h` and `UAProgressView.m` into your project.

```ruby
pod 'UAProgressView'
```

Then, simply place this line in any file that uses UAProgressView.

```objc
#import <UAProgressView.h>
```

UAProgressView works on iOS 6.0 and up.
   
## Usage

### Simple Setup

UAProgressView has sensible defaults to make setup a breeze.

1. Add a custom view to your storyboard, xib or create a UAProgressView in code.
2. Set the progress on your UAProgressView by calling `setProgress:`

The progress should be a `CGFloat` between 0 and 1, but we will round to the closest if over/under.

The default color used for UAProgressView is the view's `tintColor`, and it will travel up the superview tree as expected to set it.

--
    
### Custom Setup

There are many different configuration options to setup UAProgressView the way you want it.


##### Center View

Rather than force a stop button, label or some other canned central view, you can set the center view to be anything you want. In the example above, the `centralView` is set to a custom `UILabel`.

The `centralView` will be centered in the view but not resized, so plan accordingly when setting it up. It sits above the progress view in the layer hierarchy so it receives first tap.

There is no central view setup by default.

```objc
@property (nonatomic, strong) UIView *centralView;
```
    
Example usage:
 
```objc
UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 32.0)];
textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:32];
textLabel.textAlignment = NSTextAlignmentCenter;
textLabel.textColor = self.progressView.tintColor;
textLabel.backgroundColor = [UIColor clearColor];
self.progressView.centralView = textLabel;
```

##### Border Width

Border width is the thickness of the outer circle. It is set to 1.0 by default.

```objc
@property (nonatomic, assign) CGFloat borderWidth;
```
    
Example usage:

```objc
self.progressView.borderWidth = 2.0;
```
    
##### Line Width

Line width is the thickness of the inner circle. It is set to 1.0 by default.

```objc
@property (nonatomic, assign) CGFloat lineWidth;
```
    
Example usage:

```objc
self.progressView.lineWidth = 2.0;
```


##### Selection Indication

When `fillOnTouch` is enabled (default is `YES`), UAProgressView will immediately fill the view with the `tintColor`. If the touch is then removed (ie: selected) the fill will fade out, similar to the iOS 7 phone app.

```objc
@property (nonatomic, assign) BOOL fillOnTouch;
```

Example usage:

```objc
self.progressView.fillOnTouch = YES;
```
    

#### Animation Duration

The duration over which to animate the progress set. Default is 0.3 seconds. animationDuration < 0 is ignored.

```objc
@property (nonatomic, assign) CFTimeInterval animationDuration;
```

The `animationDuration` variable is only used when calling `setProgress:animated:` with `YES`.



### Event Blocks


##### On Select

You can set a block to be called when there was a `touchUpInside` on the progress view.

```objc
@property (nonatomic, copy) void (^didSelectBlock)(UAProgressView *progressView);
```

Example usage:

```objc
self.progressView.didSelectBlock = ^(UAProgressView *progressView){
    AudioServicesPlaySystemSound(_horn);
};
```


##### On Progress Change

You can set a block to be called whenever the progress is changed. This can be useful if the object updating the progress does not know about the central view.

```objc
@property (nonatomic, copy) void (^progressChangedBlock)(UAProgressView *progressView, CGFloat progress);
```

Example usage:

```objc
self.progressView.progressChangedBlock = ^(UAProgressView *progressView, CGFloat progress){
    [(UILabel *)progressView.centralView setText:[NSString stringWithFormat:@"%2.0f%%", progress * 100]];
};
```


##### On Fill Change

You can set a block to be called whenever the fill color is changed in your progress view. This is useful to invert colors on the central view, or do other visual updates when the progress view is filled.

```objc
@property (nonatomic, copy) void (^fillChangedBlock)(UAProgressView *progressView, BOOL filled, BOOL animated);
```

Example usage:

```objc
self.progressView.fillChangedBlock = ^(UAProgressView *progressView, BOOL filled, BOOL animated){
    UIColor *color = (filled ? [UIColor whiteColor] : progressView.tintColor);
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [(UILabel *)progressView.centralView setTextColor:color];
        }];
    } else {
        [(UILabel *)progressView.centralView setTextColor:color];
    }
};
```

### Configuration/Usage Examples

![UAProgressView](https://raw.githubusercontent.com/UrbanApps/UAProgressView/assets/UAProgressView2.gif "Example 2")

For more information on how to use and setup UAProgressView, please see the example project.

##  UAProgressView vs. MRCircularProgressView

[MRCircularProgressView](https://github.com/mrackwitz/MRProgress) is great and was the inspiration for UAProgressView, but it lacked much of the customization that UAProgressView now offers. UAProgressView is probably a better fit for you instead of MRProgress if you want:

1. More customization
2. More control
3. No additional unused classes
4. Block based interface

## Bugs / Pull Requests
Let us know if you see ways to improve UAProgressView or see something wrong with it. We are happy to pull in pull requests that have clean code, and have features that are useful for most people.

## What Does UA stand for?
[Urban Apps](http://urbanapps.com). We make neat stuff. Check us out.

## Open-Source Urban Apps Projects

- [Armchair](https://github.com/UrbanApps/Armchair) - A simple yet powerful App Review Manager for iOS and OSX (Swift)
- [UAModalPanel](https://github.com/UrbanApps/UAModalPanel) - An animated modal panel alternative for iOS
- [UAAppReviewManager](https://github.com/UrbanApps/UAAppReviewManager) - An app review prompting tool for iOS and Mac App Store apps.
- [UALogger](https://github.com/UrbanApps/UALogger) - A logging utility for Mac/iOS apps
- [UAObfuscatedString](https://github.com/UrbanApps/UAObfuscatedString) - A simple NSString category to hide sensitive strings
- [Urban](https://github.com/UrbanApps/Urban) - An Xcode color scheme that uses a soft dark background, with subtle blue, orange and yellow colors

## Feeling Generous?

If you want to thank us for open-sourcing UAProgressView, you can [buy one of our apps](http://itunes.com/apps/urbanapps?at=11l7j9&ct=github) or even donate something small.

<a href='http://www.pledgie.com/campaigns/21926'><img alt='Click here to lend your support to: Support UAProgressView Development and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/21926.png?skin_name=chrome' border='0' /></a>

