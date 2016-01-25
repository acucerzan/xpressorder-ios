//
// ReserveTableVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 14/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReserveTableVC.h"

#import "ReservationImageCell.h"
#import "ReservationNameCell.h"
#import "ReservationButtonCell.h"

#import "Table.h"
#import "Cafe.h"
#import "UIImageView+AFNetworking.h"

typedef NS_ENUM (NSInteger, ControllerType) {
	ControllerTypeCafe = 0,
	ControllerTypeTable = 1
};
typedef NS_ENUM (NSInteger, CellType) {
	CellTypeImage = 0,
	CellTypeName,
	CellTypeEmail,
	CellTypePhone,
	CellTypeDate,

	CellCount
};
@interface ReserveTableVC () <UITableViewDataSource, UITableViewDelegate>
{
	NSArray *dataSource;
	NSArray *titles;
	NSInteger viewControllerType;   // initializate with place = 0 -> initalizete with table = 1
}

@property (nonatomic, strong) Cafe *currentPlace;
@property (nonatomic, strong) Table *currentTable;
@property (weak, nonatomic) IBOutlet UITableView *tableViewReservation;

@end

@implementation ReserveTableVC

- (instancetype)loadViewControllerForPlace:(Cafe *)place
{
	ReserveTableVC *vc = [[[NSBundle mainBundle] loadNibNamed:@"ReserveTableVC" owner:self options:nil] objectAtIndex:0];
	if (vc) {
		vc.currentPlace = place;
		viewControllerType = ControllerTypeCafe;
	}
	return vc;
}

- (instancetype)loadViewControllerForTable:(Table *)table
{
	ReserveTableVC *vc = [[[NSBundle mainBundle] loadNibNamed:@"ReserveTableVC" owner:self options:nil] objectAtIndex:0];
	if (vc) {
		vc.currentTable = table;
		viewControllerType = ControllerTypeTable;
	}
	return vc;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitleString:@"Reservare"];

	[self.tableViewReservation setDelegate:self];
	[self.tableViewReservation setDataSource:self];
	[self setDataSource];
	[self.tableViewReservation reloadData];
}

#pragma mark --- Table view Delegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return section == 0 ? 0 : kReservationButtonCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		switch (indexPath.row) {
			case CellTypeImage:
				return kReservationImageCellHeight;

			case CellTypeName:
			case CellTypeEmail:
			case CellTypePhone:
			case CellTypeDate:
				return kReservationNameCellHeight;

			default:
				return kReservationButtonCellHeight;
		}
	return kReservationButtonCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return section == 0 ? CellCount : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		switch (indexPath.row) {
			case CellTypeImage:
				return [self reservationImageCellForTableView:tableView atIndexPath:indexPath];

			case CellTypeName:
				return [self nameCellForTableView:tableView atIndexPath:indexPath];

			case CellTypeEmail:
				return [self emailCellForTableView:tableView atIndexPath:indexPath];

			case CellTypePhone:
				return [self phoneNumberCellForTableView:tableView atIndexPath:indexPath];

			case CellTypeDate:
				return [self dateCellForTableView:tableView atIndexPath:indexPath];

			default:
				return nil;
		}
	else
		if (indexPath.section == 1)
			return [self buttonCellForTableView:tableView atIndexPath:indexPath];


	return nil;
}

- (ReservationImageCell *)reservationImageCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationImageCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationImageCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[titles objectAtIndex:indexPath.row]];

	if (viewControllerType == ControllerTypeCafe) {
		NSString *imageName = self.currentPlace.place_logo_image_name;

		if (imageName && imageName.length > 0) {
			[cell.imageViewPlace setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.coffeeapp.club/img/places/%@", imageName]]] placeholderImage:
			 nil                                success:
			 ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
			  [cell.imageViewPlace setImage:image];
			}                                   failure:
			 ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
			  [cell.imageViewPlace setImage:[UIImage imageNamed:@"place_list_logo"]];
			}];
		}
		else
			[cell.imageViewPlace setImage:[UIImage imageNamed:@"place_list_logo"]];
	}

	return cell;
}

- (ReservationNameCell *)nameCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationNameCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationNameCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	[cell.labelTitle setText:[titles objectAtIndex:indexPath.row]];
	[cell.textField setText:[dataSource objectAtIndex:indexPath.row]];

	return cell;
}

- (ReservationNameCell *)emailCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationNameCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationNameCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[titles objectAtIndex:indexPath.row]];
	[cell.textField setText:[dataSource objectAtIndex:indexPath.row]];

	return cell;
}

- (ReservationNameCell *)phoneNumberCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationNameCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationNameCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.labelTitle setText:[titles objectAtIndex:indexPath.row]];
	[cell.textField setText:[dataSource objectAtIndex:indexPath.row]];

	return cell;
}

- (ReservationNameCell *)dateCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationNameCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationNameCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	[cell.labelTitle setText:[titles objectAtIndex:indexPath.row]];
	[cell.textField setText:[dataSource objectAtIndex:indexPath.row]];

	return cell;
}

- (ReservationButtonCell *)buttonCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationButtonCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationButtonCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
	}
	[cell.labelTitle setText:@"Rezerva"];

	return cell;
}

#pragma mark --- Helper Functions

- (void)setDataSource
{
	titles = @[@"Rezervare", @"Nume", @"Adresa de email", @"Numar telefon", @"Cand vrei sa vii?"];
	dataSource = @[@"", @"", @"", @"", @""];
}

@end