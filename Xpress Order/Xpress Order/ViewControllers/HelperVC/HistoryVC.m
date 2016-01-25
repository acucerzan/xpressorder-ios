//
// HistoryVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 14/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "HistoryVC.h"
#import "ReviewCurrentVoteCell.h"
#import "ReviewSetVoteCell.h"
#import "ReservationButtonCell.h"

@interface HistoryVC ()

@property (nonatomic, strong) Cafe *currentPlace;

@end

@implementation HistoryVC

- (instancetype)loadViewControllerForPlace:(Cafe *)place
{
	HistoryVC *vc = [[[NSBundle mainBundle] loadNibNamed:@"HistoryVC" owner:self options:nil] objectAtIndex:0];
	if (vc)
		vc.currentPlace = place;
	return vc;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitleString:@"Istoric"];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end