//
// ReviewVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 14/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReviewVC.h"

@interface ReviewVC ()

@property (nonatomic, strong) Cafe *currentPlace;

@end

@implementation ReviewVC

- (instancetype)loadViewControllerForPlace:(Cafe *)place
{
	ReviewVC *vc = [[[NSBundle mainBundle] loadNibNamed:@"ReviewVC" owner:self options:nil] objectAtIndex:0];
	if (vc)
		vc.currentPlace = place;
	return vc;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitleString:@"Review"];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end