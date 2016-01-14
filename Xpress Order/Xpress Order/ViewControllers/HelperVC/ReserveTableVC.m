//
// ReserveTableVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 14/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReserveTableVC.h"

@interface ReserveTableVC ()

@property (nonatomic, strong) Cafe *currentPlace;

@end

@implementation ReserveTableVC

- (instancetype)loadViewControllerForPlace:(Cafe *)place
{
	ReserveTableVC *vc = [[[NSBundle mainBundle] loadNibNamed:@"ReserveTableVC" owner:self options:nil] objectAtIndex:0];
	if (vc)
		vc.currentPlace = place;
	return vc;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitleString:@"Reservare"];
}

/*
 * #pragma mark - Navigation
 *
 *  // In a storyboard-based application, you will often want to do a little preparation before navigation
 *  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 *   // Get the new view controller using [segue destinationViewController].
 *   // Pass the selected object to the new view controller.
 *  }
 */

@end