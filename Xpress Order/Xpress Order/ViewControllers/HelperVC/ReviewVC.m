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
	CellButton,

	CellCount
};

@interface ReviewVC () <UITableViewDataSource, UITableViewDelegate>
{
	NSArray *dataSource;
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
	return CellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case CellTypeTitle:
			return [self titleCellForTableView:tableView atIndexPath:indexPath];

		case CellTypeRating:
			return [self ratingCellForTableView:tableView atIndexPath:indexPath];

		case CellTypeVote:
			return [self voteCellForTableView:tableView atIndexPath:indexPath];

		case CellButton:
			return [self buttonCellForTableView:tableView atIndexPath:indexPath];

		default:
			return nil;
	}
}

- (ReservationButtonCell *)titleCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationButtonCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationButtonCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[dataSource objectAtIndex:indexPath.row]];
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
	cell.viewRating.value = [self.currentPlace.place_review floatValue];

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
	return cell;
}

- (ReservationButtonCell *)buttonCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationButtonCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationButtonCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[dataSource objectAtIndex:indexPath.row]];
	return cell;
}

@end