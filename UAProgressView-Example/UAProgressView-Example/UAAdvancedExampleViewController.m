//
//  UAAdvancedExampleViewController.m
//  UAProgressView-Example
//
//  Created by Matt Coneybeare on 5/26/14.
//  Copyright (c) 2014 Urban Apps. All rights reserved.
//

#import "UAAdvancedExampleViewController.h"

#import <AudioToolbox/AudioToolbox.h>

#import <UAProgressView/UAProgressView.h>

@interface UAAdvancedExampleViewController ()

@property (nonatomic, weak) IBOutlet UAProgressView *progressView;

@property (nonatomic, assign) SystemSoundID horn;
@property (nonatomic, assign) BOOL paused;
@property (nonatomic, assign) CGFloat localProgress;

@end

@implementation UAAdvancedExampleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.paused = YES;
	
	self.progressView.tintColor = [UIColor colorWithRed:5/255.0 green:204/255.0 blue:197/255.0 alpha:1.0];
	self.progressView.borderWidth = 2.0;
	self.progressView.lineWidth = 2.0;
	self.progressView.fillOnTouch = YES;
	
	UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 32.0)];
	textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:32];
	textLabel.textAlignment = NSTextAlignmentCenter;
	textLabel.textColor = self.progressView.tintColor;
	textLabel.backgroundColor = [UIColor clearColor];
	self.progressView.centralView = textLabel;
	
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
	
	self.progressView.progressChangedBlock = ^(UAProgressView *progressView, CGFloat progress){
		[(UILabel *)progressView.centralView setText:[NSString stringWithFormat:@"%2.0f%%", progress * 100]];
	};
	
	NSString *path  = [[NSBundle mainBundle] pathForResource:@"horn" ofType:@"caf"];
	NSURL *pathURL = [NSURL fileURLWithPath : path];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &_horn);
	
	self.progressView.didSelectBlock = ^(UAProgressView *progressView){
		AudioServicesPlaySystemSound(_horn);
		_paused = !_paused;
	};
	
	self.progressView.progress = 0;
	
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
}

- (void)updateProgress:(NSTimer *)timer {
	if (!_paused) {
		_localProgress = ((int)((_localProgress * 100.0f) + 1.01) % 100) / 100.0f;
		[self.progressView setProgress:_localProgress];
	}
}

@end
