//
// TableViewDetail.m
// Xpress Order
//
// Created by Constantin Saulenco on 16/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableViewDetailVC.h"
#import "DWBubbleMenuButton.h"
#import "ProductSelectionVC.h"

#import "Table.h"

@interface TableViewDetailVC ()
{
	__weak IBOutlet UILabel *labelTableViewId;
	__weak IBOutlet UILabel *labelSpaceName;
	__weak IBOutlet DWBubbleMenuButton *viewShare;
	__weak IBOutlet UIView *viewBottomBase;
	__weak IBOutlet UILabel *labelTable;
	__weak IBOutlet UIView *viewTableLabelBase;

	NSArray *buttons;
	Table *selectedTable;
}

@end

@implementation TableViewDetailVC


- (instancetype)initWithTable:(Table *)table
{
	self = [self initWithNibName:@"TableViewDetailVC" bundle:[NSBundle mainBundle]];
	if (self)
		selectedTable = table;

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	XPModel *shared = [XPModel sharedInstance];

	[labelSpaceName setText:shared.selectedCafe.place_name];
	[labelSpaceName setTextColor:[UIColor whiteColor]];
	[labelSpaceName setFont:MainFontBold(40)];

	[labelTableViewId setText:shared.selectedTable.table_id];
	[labelTableViewId setTextColor:[UIColor whiteColor]];
	[labelSpaceName setFont:MainFontBold(50)];

	[labelTable setText:shared.selectedTable.isTable ? kTableName : kBarTName];
	[labelTable setTextColor:[UIColor whiteColor]];
	[labelTable setFont:MainFontRegular(16)];

	// [self loadBackButton];
	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.title = @"Back";
	[self setTitleString:@"Welcome"];

	[self addSharedBoobles];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	  viewTableLabelBase.transform = CGAffineTransformMakeScale(1.3, 1.3);
	} completion:^(BOOL finished) {
	  [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	    viewTableLabelBase.transform = CGAffineTransformMakeScale(1, 1);
		}];
	}];
}

- (void)addSharedBoobles
{
	[viewShare setBackgroundColor:[UIColor clearColor]];

	// Create up menu button
	UIImageView *imageView = [self createHomeButtonView];
	viewShare.homeButtonView = imageView;
	[viewShare addButtons:[self createButtonArray]];
}

- (UIImageView *)createHomeButtonView
{
	CGRect frame = viewShare.frame;
	frame.origin.x = 0;
	frame.origin.y = 0;

	UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];

	[imageView setImage:[UIImage imageNamed:@"social_media_button"]];

	return imageView;
}

- (NSArray *)createButtonArray
{
	NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];

	viewShare.buttonSpacing = 5;

	int i = 0;
	for (NSString *title in @[@"share_twitter", @"share_facebook", @"share_google"]) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setTitle:@"" forState:UIControlStateNormal];
		[button setImage:[UIImage imageNamed:title] forState:0];

		button.frame = CGRectMake(0.f, 0.f, 35.f, 35.f);
		button.layer.cornerRadius = button.frame.size.height / 2.f;
		// button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
		button.clipsToBounds = YES;
		button.tag = i++;

		[button addTarget:self action:@selector(buttonSocialPress:) forControlEvents:1 << 6];
		[button setUserInteractionEnabled:YES];

		[buttonsMutable addObject:button];
	}

	buttons = buttonsMutable;

	return buttons;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)downloadFoodsAndCategories
{
	XPModel *shared = [XPModel sharedInstance];

	if (shared.selectedCafe) {
		MainNetworkingDataSource *main = [shared mainNetworkingDataSource];

		[main getCategoryFoodforPlaceID:shared.selectedCafe.place_id andTableNumber:shared.selectedTable.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
		  NSLog(@"Finished getting food categories");

		  if (items)
				for (CategoryModel *categ in items)
					NSLog(@"%@", [categ description]);
		}];
	}
}

- (IBAction)buttonMenuPress:(id)sender
{
	ProductSelectionVC *productSelection = [[ProductSelectionVC alloc] initWithNibName:@"ProductSelectionVC" andSelectedTable:[XPModel sharedInstance].selectedTable];
	[self.navigationController pushViewController:productSelection animated:YES];

	NSLog(@"Button Menu Press");
}

- (IBAction)buttonCallPress:(id)sender
{
	XPModel *shared = [XPModel sharedInstance];
	MainNetworkingDataSource *main = [shared mainNetworkingDataSource];

	[main callWaitressforPlaceID:shared.selectedTable.place_id andTableNumber:shared.selectedTable.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  if (!error)
			NSLog(@"wait for waitress");
	}];
	NSLog(@"Button Call Press");
}

- (IBAction)buttonSocialPress:(id)sender
{
	switch ([sender tag]) {
		case 0:
			NSLog(@"Twitter pressed");
			break;

		case 1:
			NSLog(@"facebook pressed");
			break;

		case 2:
			NSLog(@"google pressed");
			break;

		case 3:
			NSLog(@"Exit pressed");
			break;

		default:
			break;
	}
}

@end