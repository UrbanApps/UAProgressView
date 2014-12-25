//
//  UAViewController.m
//  UAProgressView-Example
//
//  Created by Matt Coneybeare on 5/25/14.
//  Copyright (c) 2014 Urban Apps. All rights reserved.
//

#import "UABasicExampleViewController.h"

#import <UAProgressView/UAProgressView.h>

@interface UABasicExampleViewController ()

@property (nonatomic, weak) IBOutlet UAProgressView *progressView1;
@property (nonatomic, weak) IBOutlet UAProgressView *progressView2;
@property (nonatomic, weak) IBOutlet UAProgressView *progressView3;
@property (nonatomic, weak) IBOutlet UAProgressView *progressView4;
@property (nonatomic, weak) IBOutlet UAProgressView *progressView5;
@property (nonatomic, weak) IBOutlet UAProgressView *progressView6;

@property (nonatomic, assign) CGFloat localProgress;

@end

@implementation UABasicExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
		
	[self setupProgressView1];
	[self setupProgressView2];
	[self setupProgressView3];
	[self setupProgressView4];
	[self setupProgressView5];
	[self setupProgressView6];
	
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
}

- (void)setupProgressView1 {
	// no-op. Default
}

- (void)setupProgressView2 {
	self.progressView2.tintColor = [UIColor purpleColor];
	self.progressView2.borderWidth = 10.0;
	self.progressView2.lineWidth = 10.0;
}

- (void)setupProgressView3 {
	self.progressView3.tintColor = [UIColor purpleColor];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 20.0)];
	[label setTextAlignment:NSTextAlignmentCenter];
	label.userInteractionEnabled = NO; // Allows tap to pass through to the progress view.
	self.progressView3.centralView = label;
	
	self.progressView3.progressChangedBlock = ^(UAProgressView *progressView, CGFloat progress) {
		[(UILabel *)progressView.centralView setText:[NSString stringWithFormat:@"%2.0f%%", progress * 100]];
	};
}

- (void)setupProgressView4 {
	UIView *view = [[UIView alloc] initWithFrame:CGRectInset(self.progressView4.bounds, self.progressView4.bounds.size.width / 3.0, self.progressView4.bounds.size.height / 3.0)];
	view.backgroundColor = [UIColor redColor];
	view.userInteractionEnabled = NO; // Allows tap to pass through to the progress view.
	self.progressView4.centralView = view;
	
	self.progressView4.fillChangedBlock = ^(UAProgressView *progressView, BOOL filled, BOOL animated){
		UIColor *color = (filled ? [UIColor whiteColor] : [UIColor redColor]);
		if (animated) {
			[UIView animateWithDuration:0.3 animations:^{
				progressView.centralView.backgroundColor = color;
			}];
		} else {
			progressView.centralView.backgroundColor = color;
		}
	};
}

- (void)setupProgressView5 {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
	[button setFrame:CGRectMake(0, 0, 32, 32)];
	[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	self.progressView5.fillOnTouch = NO;
	self.progressView5.centralView = button;
}

- (void)setupProgressView6 {
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 60.0)];
	[label setTextAlignment:NSTextAlignmentCenter];
	label.userInteractionEnabled = NO; // Allows tap to pass through to the progress view.
	label.text = @"Tap me\nto update";
	label.numberOfLines = 0;
	label.font = [UIFont systemFontOfSize:10];
	self.progressView6.centralView = label;
	
	self.progressView6.fillOnTouch = NO;
	self.progressView6.didSelectBlock = ^(UAProgressView *progressView){
		[progressView setProgress:_localProgress animated:YES];
	};
}

- (void)updateProgress:(NSTimer *)timer {
	_localProgress = ((int)((_localProgress * 100.0f) + 1.01) % 100) / 100.0f;
	
	[self.progressView1 setProgress:_localProgress];
	[self.progressView2 setProgress:_localProgress];
	[self.progressView3 setProgress:_localProgress];
	[self.progressView4 setProgress:_localProgress];
	[self.progressView5 setProgress:_localProgress animated:YES];
//	[self.progressView6 setProgress:_localProgress]; // 6 is done on tap
}

- (void)buttonTapped:(id)sender {
	NSLog(@"Button tapped");
}

@end
