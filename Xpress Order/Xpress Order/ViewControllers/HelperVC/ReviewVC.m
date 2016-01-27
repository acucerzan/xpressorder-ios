//
// ReviewVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 14/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReviewVC.h"

#import "ReviewCurrentVoteCell.h"
#import "ReviewSetVoteCell.h"
#import "ReservationButtonCell.h"

typedef NS_ENUM (NSInteger, CellType) {
	CellTypeTitle = 0,
	CellTypeRating,
	CellTypeVote,

	CellCount
};

@interface ReviewVC () <UITableViewDataSource, UITableViewDelegate>
{
	NSArray *dataSource;
	CGFloat selectedRating;
}

@property (nonatomic, strong) Cafe *currentPlace;
@property (weak, nonatomic) IBOutlet UITableView *tableViewReview;

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
	[self setDataSource];

	[self.tableViewReview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableViewReview setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.10]];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark --- HelperFunction

- (void)setDataSource
{
	dataSource = @[@"Recenzii", @"", @"Selecteaza", @"Trimite"];
}

#pragma mark --- Table view Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return kReservationButtonCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableViewReview.frame.size.width, kReservationButtonCellHeight)];
	[view setBackgroundColor:[UIColor clearColor]];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case CellTypeTitle:
			return kReservationButtonCellHeight;

		case CellTypeRating:
			return kReviewCurrentVoteCellHeight;

		case CellTypeVote:
			return kReviewSetVoteCellHeight;

		default:
			break;
	}
	return kReservationButtonCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0)
		return CellCount;
	else
		return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		switch (indexPath.row) {
			case CellTypeTitle:
				return [self titleCellForTableView:tableView atIndexPath:indexPath];

			case CellTypeRating:
				return [self ratingCellForTableView:tableView atIndexPath:indexPath];

			case CellTypeVote:
				return [self voteCellForTableView:tableView atIndexPath:indexPath];

			default:
				return nil;
		}

	if (indexPath.section == 1)
		return [self buttonCellForTableView:tableView atIndexPath:indexPath];

	return nil;
}

- (ReservationButtonCell *)titleCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationButtonCell"];

	if (!cell) {
		cell = LoadCell(@"ReservationButtonCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[dataSource objectAtIndex:indexPath.row]];
	[cell setSeparatorsHidden:YES];

	[cell.viewTopSeparator setHidden:NO];
	return cell;
}

- (ReviewCurrentVoteCell *)ratingCellForTableView:(UITableView *)tableview atIndexPath:(NSIndexPath *)indexPath
{
	ReviewCurrentVoteCell *cell = [tableview dequeueReusableCellWithIdentifier:@"ReviewCurrentVoteCell"];
	if (!cell) {
		cell = LoadCell(@"ReviewCurrentVoteCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[NSString stringWithFormat:@" %.1f", [self.currentPlace.place_review floatValue]]];
	[cell.labelTitle setFont:MainFontMedium(40)];

	cell.viewRating.value = [self.currentPlace.place_review floatValue];
	[cell.viewRating setSpacing:1];

	return cell;
}

- (ReviewSetVoteCell *)voteCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReviewSetVoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewSetVoteCell"];
	if (!cell) {
		cell = LoadCell(@"ReviewSetVoteCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[dataSource objectAtIndex:indexPath.row]];
	[cell.labelTitle setFont:MainFontMedium(30)];
	[cell.labelTitle setTextColor:XP_PURPLE];

	[cell.viewVote setSpacing:1];
	[cell.viewVote addTarget:self action:@selector(ratingViewChanged:) forControlEvents:UIControlEventValueChanged];

	return cell;
}

- (ReservationButtonCell *)buttonCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationButtonCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationButtonCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:@"Trimite"];
	return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		[cell.contentView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.2]];
	}
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		[cell.contentView setBackgroundColor:[UIColor whiteColor]];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1)
		[self sendReview];
}

#pragma mark --- Helper functions

- (void)sendReview
{
	MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
	[networkingDataSource setReview:[NSNumber numberWithFloat:selectedRating] forPlaceWithId:self.currentPlace.place_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo)
    {
        if(!error)
        {
            MakeAlert(@"Success", @"Va multumim pentru evaluare!");
            [self.navigationController popViewControllerAnimated:YES];
        }
	}];

	
}

- (void)ratingViewChanged:(HCSStarRatingView *)sender
{
	NSLog(@"Value changed to %.1f", sender.value);
	selectedRating = sender.value;
}

@end