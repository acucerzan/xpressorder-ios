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
#import "ReservationDateCell.h"

#import "Table.h"
#import "Cafe.h"
#import "UIImageView+AFNetworking.h"

#import "UITextField+Types.h"
#import "Reservation.h"

#define kDefaulttextFieldTag 100

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
	CellTypePreferedSeats,
	CellTypeObservation,

	CellCount
};
@interface ReserveTableVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
	NSMutableArray *dataSource;
	NSArray *titles;
	NSInteger viewControllerType;   // initializate with place = 0 -> initalizete with table = 1
	NSInteger cellsCount;
	NSDate *selectedDate;
	NSInteger selectedIndex;

	BOOL sized;
}

@property (nonatomic, strong) Cafe *currentPlace;
@property (nonatomic, strong) Table *currentTable;
@property (weak, nonatomic) IBOutlet UITableView *tableViewReservation;
@property (nonatomic, strong) UITextField *actifText;

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

	// Register notification when the keyboard will be show
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillShow:)
	                                             name:UIKeyboardWillShowNotification
	                                           object:nil];

	// Register notification when the keyboard will be hide
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillHide:)
	                                             name:UIKeyboardWillHideNotification
	                                           object:nil];

	[self.tableViewReservation setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableViewReservation setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.10]];

	[self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark --- Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)note
{
	// Get the keyboard size
	CGRect keyboardFrame = [[note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];

	if (sized)
		return;

	sized = YES;

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		CGSize size = self.tableViewReservation.contentSize;
		size.height += keyboardFrame.size.height;

		[self.tableViewReservation setContentSize:size];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.tableViewReservation scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
		});
	});
}

- (void)keyboardWillHide:(NSNotification *)note
{
	// Get the keyboard size
	CGRect keyboardFrame = [[note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];

	if (!sized)
		return;

	sized = NO;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		CGSize size = self.tableViewReservation.contentSize;
		size.height -= keyboardFrame.size.height;

		[self.tableViewReservation setContentSize:size];
	});
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 1) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableViewReservation.frame.size.width, kReservationButtonCellHeight)];
		[view setBackgroundColor:[UIColor clearColor]];
		return view;
	}

	return nil;
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

			case CellTypePreferedSeats:
				if (cellsCount > CellCount)
					return kReservationDateCellHeight;

				return kReservationNameCellHeight;

			case CellTypeObservation:
				if (cellsCount > CellCount)
					return kReservationNameCellHeight;

				return kReservationButtonCellHeight * 2;

			case CellCount:
				return kReservationButtonCellHeight * 2;

			default:
				return kReservationButtonCellHeight;
		}
	return kReservationButtonCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return section == 0 ? cellsCount : 1;
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

			case CellTypePreferedSeats:
				if (cellsCount > CellCount)
					return [self datePickerCellForTableView:tableView atIndexPath:indexPath];

				return [self seatsCellForTableView:tableView atIndexPath:indexPath];

			case CellTypeObservation:
				if (cellsCount > CellCount)
					return [self seatsCellForTableView:tableView atIndexPath:indexPath];

				return [self observationCellForTableView:tableView atIndexPath:indexPath];

			case CellCount:
				return [self observationCellForTableView:tableView atIndexPath:indexPath];

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

	[cell.textField setTag:kDefaulttextFieldTag + indexPath.row];

	[cell.textField setTextFieldType:TextFieldTypeAlpaNumerical];
	[cell.textField setMaxLength:30];

	[cell.textField setKeyboardType:UIKeyboardTypeASCIICapable];
	[cell.textField setReturnKeyType:UIReturnKeyNext];
	[cell.textField setDelegate:self];

	[cell.viewSeparator setHidden:YES];
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

	[cell.textField setTag:kDefaulttextFieldTag + indexPath.row];

	[cell.textField setTextFieldType:TextFieldTypeEmail];
	[cell.textField setMaxLength:30];

	[cell.textField setKeyboardType:UIKeyboardTypeASCIICapable];
	[cell.textField setReturnKeyType:UIReturnKeyNext];
	[cell.textField setDelegate:self];

	[cell.viewSeparator setHidden:YES];
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

	[cell.textField setTag:kDefaulttextFieldTag + indexPath.row];

	[cell.textField setTextFieldType:TextFieldTypeNumerical];
	[cell.textField setMaxLength:10];
	[cell.textField setReturnKeyType:UIReturnKeyNext];
	[cell.textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];

	[cell.textField setDelegate:self];

	[cell.viewSeparator setHidden:YES];
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

	[cell.textField setTag:kDefaulttextFieldTag + indexPath.row];
	[cell.textField setDelegate:self];

	[cell.viewSeparator setHidden:YES];
	return cell;
}

- (ReservationNameCell *)seatsCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationNameCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationNameCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	NSInteger index = indexPath.row;
	if (cellsCount > CellCount)
		index -= 1;

	[cell.labelTitle setText:[titles objectAtIndex:index]];
	[cell.textField setText:[dataSource objectAtIndex:index]];

	[cell.textField setTextFieldType:TextFieldTypeNumerical];
	[cell.textField setMaxLength:5];
	[cell.textField setReturnKeyType:UIReturnKeyNext];
	[cell.textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];

	[cell.textField setTag:kDefaulttextFieldTag + index];
	[cell.textField setDelegate:self];

	[cell.viewSeparator setHidden:YES];
	return cell;
}

- (ReservationNameCell *)observationCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationNameCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationNameCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	NSInteger index = indexPath.row;
	if (cellsCount > CellCount)
		index -= 1;

	[cell.labelTitle setText:[titles objectAtIndex:index]];
	[cell.textField setText:[dataSource objectAtIndex:index]];

	[cell.textField setTextFieldType:TextFieldTypeAlpaNumerical];
	[cell.textField setMaxLength:100];
	[cell.textField setReturnKeyType:UIReturnKeyDone];
	[cell.textField setKeyboardType:UIKeyboardTypeAlphabet];

	[cell.textField setTag:kDefaulttextFieldTag + index];
	[cell.textField setDelegate:self];

	[cell.viewSeparator setHidden:NO];
	return cell;
}

- (ReservationButtonCell *)buttonCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationButtonCell"];
	if (!cell)
		cell = LoadCell(@"ReservationButtonCell");
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	[cell.labelTitle setText:@"Rezerva"];

	return cell;
}

- (ReservationDateCell *)datePickerCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
	ReservationDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationDateCell"];
	if (!cell) {
		cell = LoadCell(@"ReservationDateCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	[cell.datePicker addTarget:self action:@selector(dateHasChanged:) forControlEvents:UIControlEventValueChanged];
	[cell.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];

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
		[self makeReservation];
}

#pragma mark --- TextFieldDeletate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL value = [textField textField:textField shouldChangeCharactersInRange:range replacementString:string];

	return value;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	NSInteger tag = textField.tag - kDefaulttextFieldTag;

	selectedIndex = tag;

	if (tag == CellTypeDate) {
		if (cellsCount == CellCount)
			[self insertDateCell];
		return NO;
	}
	else
		if (cellsCount > CellCount)
			[self deleteDateCell];

	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSInteger tag = textField.tag - kDefaulttextFieldTag;
	switch (tag) {
		case CellTypeName:
			[dataSource replaceObjectAtIndex:CellTypeName withObject:textField.text];
			break;

		case CellTypeEmail:
			[dataSource replaceObjectAtIndex:CellTypeEmail withObject:textField.text];
			break;

		case CellTypePhone:
			[dataSource replaceObjectAtIndex:CellTypePhone withObject:textField.text];
			break;

		case CellTypePreferedSeats:
			[dataSource replaceObjectAtIndex:CellTypePreferedSeats withObject:textField.text];
			break;

		case CellTypeObservation:
			[dataSource replaceObjectAtIndex:CellTypeObservation withObject:textField.text];
			break;

		default:
			break;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSInteger tag = textField.tag - kDefaulttextFieldTag;
	switch (tag) {
		case CellTypeName:
			[self goToNextTextFieldFromTextField:textField];
			break;

		case CellTypeEmail:
			[self goToNextTextFieldFromTextField:textField];
			break;

		case CellTypePhone:
			[self goToNextTextFieldFromTextField:textField];
			break;

		case CellTypeDate:
			[self insertDateCell];
			break;

		case CellTypePreferedSeats:
			[self goToNextTextFieldFromTextField:textField];
			break;

		case CellTypeObservation:
			[self.view endEditing:YES];

			break;

		default:
			break;
	}
	return YES;
}

#pragma mark --- Helper Functions

- (void)makeReservationFor:(Reservation *)reservation
{
	MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
	[networkingDataSource createReservation:reservation withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo)
	{
	  if (!error) {
	    NSString *message = @"";

	    if (items.count > 1)
				message = [NSString stringWithFormat:@"Reservarea s-a efectuat cu success! Codul dumneavoastra de access este :%@", [items objectAtIndex:1]];
	    MakeAlert(@"Success", message);
	    [self.navigationController popViewControllerAnimated:YES];
		}
	}];
}

- (void)makeReservation
{
	if (viewControllerType == ControllerTypeCafe) {
		Reservation *reserv = [[Reservation alloc] init];
		reserv.place = self.currentPlace;
		reserv.clientName = [dataSource objectAtIndex:CellTypeName];
		reserv.clientEmail = [dataSource objectAtIndex:CellTypeEmail];
		reserv.clientPhone = [dataSource objectAtIndex:CellTypePhone];
		reserv.clientDate = selectedDate;
		reserv.personCount = [dataSource objectAtIndex:CellTypePreferedSeats];
		reserv.clientObservation = [dataSource objectAtIndex:CellTypeObservation];

		[self makeReservationFor:reserv];
		NSLog(@"controller type CAFE");
	}
	else
		// make reservation for the table ap
		NSLog(@"controller type table");
}

- (void)dateHasChanged:(UIDatePicker *)sender
{
	ReservationNameCell *cell = [self.tableViewReservation cellForRowAtIndexPath:[NSIndexPath indexPathForRow:CellTypeDate inSection:0]];
	NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
	[dateFormater setDateStyle:NSDateFormatterFullStyle];

	NSDateFormatter *timeFormater = [[NSDateFormatter alloc] init];
	[timeFormater setTimeStyle:NSDateFormatterShortStyle];

	selectedDate = sender.date;
	[cell.textField setText:[NSString stringWithFormat:@"%@ la %@", [dateFormater stringFromDate:sender.date], [timeFormater stringFromDate:sender.date]]];
	[dataSource replaceObjectAtIndex:CellTypeDate withObject:cell.textField.text];
}

- (void)setDataSource
{
	titles = @[@"Rezervare", @"Nume", @"Adresa de email", @"Numar telefon", @"Cand vrei sa vii?", @"Locuri dorite", @"Observatii"];
	dataSource = [NSMutableArray arrayWithArray:@[@"", @"", @"", @"", @"", @"", @""]];
	cellsCount = CellCount;
}

- (void)goToNextTextFieldFromTextField:(UITextField *)textField
{
	NSInteger nextTag = textField.tag + 1;
	// [textField resignFirstResponder];

	UITextField *nextTextField = (UITextField *) [self.view viewWithTag:nextTag];
	[nextTextField becomeFirstResponder];

	[self.tableViewReservation scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(nextTag - kDefaulttextFieldTag) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)insertDateCell
{
	sized = NO;
	[self.view endEditing:YES];
	cellsCount += 1;

	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:CellTypeDate + 1 inSection:0];
	[self.tableViewReservation beginUpdates];
	[self.tableViewReservation insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[self.tableViewReservation endUpdates];

	[self.tableViewReservation scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:CellTypeDate inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)deleteDateCell
{
	cellsCount = CellCount;

	NSArray *reloadedIndexes = @[[NSIndexPath indexPathForRow:CellTypePreferedSeats inSection:0], [NSIndexPath indexPathForRow:CellTypeObservation inSection:0]];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:CellCount inSection:0];
	[self.tableViewReservation beginUpdates];
	[self.tableViewReservation deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[self.tableViewReservation reloadRowsAtIndexPaths:reloadedIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
	[self.tableViewReservation endUpdates];
}

@end