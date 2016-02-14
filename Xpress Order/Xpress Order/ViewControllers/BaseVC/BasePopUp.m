//
// BasePopUp.m
// Xpress Order
//
// Created by Constantin Saulenco on 11/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "BasePopUp.h"

@interface BasePopUp ()

@end

@implementation BasePopUp

- (void)viewDidLoad
{
	[super viewDidLoad];


	self.viewContainer.layer.cornerRadius = 5;
	self.viewContainer.clipsToBounds = YES;
	self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];

	[self applyMotionEffectsForView:self.viewContainer];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#define  kCustomIOS7MotionEffectExtent 20.0

- (void)applyMotionEffectsForView:(UIView *)view
{
	if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
		return;


	UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
	                                                                                                type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	horizontalEffect.minimumRelativeValue = @(-kCustomIOS7MotionEffectExtent);
	horizontalEffect.maximumRelativeValue = @(kCustomIOS7MotionEffectExtent);

	UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
	                                                                                              type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	verticalEffect.minimumRelativeValue = @(-kCustomIOS7MotionEffectExtent);
	verticalEffect.maximumRelativeValue = @(kCustomIOS7MotionEffectExtent);

	UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
	motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];

	[view addMotionEffect:motionEffectGroup];
}

#pragma mark --- Helper Function

- (void)showPopUpInViewController:(UIViewController *)viewController
{
	CGRect frame = [UIScreen mainScreen].bounds;
	frame.origin.y = 0;
	self.view.frame = frame;

	[self.view setAlpha:0];

	[viewController.navigationController addChildViewController:self];
	[viewController.navigationController.view addSubview:self.view];

	[self didMoveToParentViewController:self];

	self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);

	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
	{
	  self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
	  self.view.alpha = 1;
	}
	                 completion:^(BOOL finished) {
	  if (finished)
			[self viewWillAppear:YES];
	}];
}

- (void)closePopUp
{
	self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);

	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
	{
	  self.view.alpha = 0;
	  self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
	}                completion:^(BOOL finished)
	{
	  [self removeFromParentViewController];
	  [self.view removeFromSuperview];
	}];
}

- (void)addTapToQuit
{
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePopUp)];
	[self.view addGestureRecognizer:tapGesture];
}

@end