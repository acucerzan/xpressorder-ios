//
// MasterViewController.m
// Xpress Order
//
// Created by Adrian Cucerzan on 02/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "PlacesVC.h"
#import "TableSelectionVC.h"
#import "HCSStarRatingView.h"

#import "PlaceCell.h"

#import "ReviewVC.h"
#import "HistoryVC.h"
#import "ReserveTableVC.h"

// test
#import "TableReservedPopUp.h"

#define ReviewTAG 120

@interface PlacesVC () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *arrayCafe;
@property (nonatomic, weak) Cafe *weakReferenceWhileAlertView;

@end

@implementation PlacesVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	[self initialise];

	[self downloadPlaces];


// TableReservedPopUp *tablePopUp = [[TableReservedPopUp alloc] initWithNibName:@"TableReservedPopUp" bundle:[NSBundle mainBundle]];
// [tablePopUp showPopUpInViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)initialise
{
	self.arrayCafe = [NSMutableArray arrayWithCapacity:0];

	[self.myTableView setBackgroundColor:[UIColor clearColor]];
	[self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

	self.navigationController.navigationBar.barTintColor = XP_PURPLE;
	[self setTitleString:@"Alegeți locația dorită"];
}

- (void)downloadPlaces
{
	MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];

	[networkingDataSource getPlacesWithCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  NSLog(@"Finished places request");

	  if (items) {
	    if (items.count > 0)
				NSLog(@"Cafe items: %@", items);

	    [self.arrayCafe removeAllObjects];
	    [self.arrayCafe addObjectsFromArray:items];

	    [self.myTableView reloadData];
		}
	}];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == ReviewTAG) {
		NSLog(@"Button index: %d", (int) buttonIndex);

		if (buttonIndex == 1) {
			MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];

			[networkingDataSource setReview:self.weakReferenceWhileAlertView.place_review forPlaceWithId:self.weakReferenceWhileAlertView.place_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
			  NSLog(@"Finished set review request");
			}];
		}
	}
}

- (void)setReview:(id)sender
{
	CafeReviewButton *btn = (CafeReviewButton *) sender;

	if (btn.weakPlace) {
		NSLog(@"Clicked review for Place: %@", btn.weakPlace);

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Trimite recenzie" message:[NSString stringWithFormat:@"Doriți să trimiteți %.1f stele pentru %@?", [btn.weakPlace.place_review floatValue], btn.weakPlace.place_name] delegate:self cancelButtonTitle:@"Nu" otherButtonTitles:@"Da", nil];

		self.weakReferenceWhileAlertView = btn.weakPlace;

		alert.tag = ReviewTAG;

		[alert show];
	}
}

#pragma mark UIBUttonAction

- (IBAction)buttonHistoryPress:(id)sender
{
	Cafe *cafeObj = [self.arrayCafe objectAtIndex:[sender tag]];
	HistoryVC *vc = [[HistoryVC alloc] loadViewControllerForPlace:cafeObj];
	[self.navigationController pushViewController:vc animated:YES];

	NSLog(@"button history press");
}

- (IBAction)buttonReserveTablePress:(id)sender
{
	Cafe *cafeObj = [self.arrayCafe objectAtIndex:[sender tag]];
	ReserveTableVC *vc = [[ReserveTableVC alloc] loadViewControllerForPlace:cafeObj];
	[self.navigationController pushViewController:vc animated:YES];

	NSLog(@"button reserve table press");
}

- (IBAction)buttonReviewPress:(id)sender
{
	Cafe *cafeObj = [self.arrayCafe objectAtIndex:[sender tag]];
	ReviewVC *vc = [[ReviewVC alloc] loadViewControllerForPlace:cafeObj];
	[self.navigationController pushViewController:vc animated:YES];
	NSLog(@"button review press");
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.arrayCafe.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifierLast = @"cellIdentifierLast1";
	PlaceCell *cell = (PlaceCell *) [self.myTableView dequeueReusableCellWithIdentifier:cellIdentifierLast];

	if (!cell) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:self options:nil];
		cell = (PlaceCell *) [nib objectAtIndex:0];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	cell.backgroundColor = [UIColor clearColor];

	Cafe *cafeObj = [self.arrayCafe objectAtIndex:indexPath.row];

	[cell loadItem:cafeObj];

	[cell.buttonHistory addTarget:self action:@selector(buttonHistoryPress:) forControlEvents:1 << 6];
	[cell.buttonHistory setTag:indexPath.row];
	[cell.buttonReservTable addTarget:self action:@selector(buttonReserveTablePress:) forControlEvents:1 << 6];
	[cell.buttonReservTable setTag:indexPath.row];
	[cell.buttonReview addTarget:self action:@selector(buttonReviewPress:) forControlEvents:1 << 6];
	[cell.buttonReview setTag:indexPath.row];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"%@", indexPath);

	Cafe *cafeObj = [self.arrayCafe objectAtIndex:indexPath.row];

	TableSelectionVC *vc = [[TableSelectionVC alloc] loadFromNibForPlace:cafeObj];
	[[XPModel sharedInstance] setSelectedCafe:cafeObj];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	PlaceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[cell.contentView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.2]];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	PlaceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[cell.contentView setBackgroundColor:ClearColor];
}

@end