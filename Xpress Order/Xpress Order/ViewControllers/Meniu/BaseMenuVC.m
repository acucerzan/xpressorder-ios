//
// BaseMenuVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 11/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "BaseMenuVC.h"

#import "Table.h"
#import "ProductCell.h"


@interface BaseMenuVC ()


@end

@implementation BaseMenuVC

- (instancetype)initWithNibName:(NSString *)nibName andSelectedTable:(Table *)table
{
	self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
	if (self) {
		self.selectedTable = table;
		[self menuForTable:table];
	}

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.tableViewProducts setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.labelCategoryName setFont:MainFontBold(30)];
	[self.labelCategoryName setTextColor:[XP_PURPLE colorWithAlphaComponent:.7]];

	[self.labelCategoryName setText:@""];
	[self.tableViewProducts setHidden:YES];
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

#pragma mark --- Network place

- (void)menuForTable:(Table *)table;
{
	[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

	MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];

	[networkingDataSource getCategoryFoodforPlaceID:table.place_id andTableNumber:table.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  if (!error) {
	    self.categoryList = items;
	    self.originalCategoryList = items;
	    [self populateCategoryView];
		}


	  dispatch_async(mainThread, ^{
			[self.tableViewProducts setHidden:NO];
			[SVProgressHUD dismiss];
		});
	}];
}

#pragma mark --- helperFunctions
- (void)reloadScrollView
{
	[self.scrollViewCategory.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self populateCategoryView];
	});
}

- (void)populateCategoryView
{
	int yPosition = 0;
	int tagValue = 0;

	for (CategoryModel *categ in self.categoryList) {
		ProductGroupCell *cell = LoadCell(@"ProductGroupCell");

		[cell.labelCategory setText:categ.strCategoryName];
		[cell.labelCategory setTextColor:[UIColor whiteColor]];
		[cell.labelCategory setFont:MainFontRegular(10)];

		[cell imageFromURLString:categ.imgCategoryLogo];
		[cell setBackgroundColor:ClearColor];

		[cell.imageCategory setTag:kDefaultImageTag + tagValue];
		[cell.buttonCategory setTag:tagValue];
		[cell.buttonCategory addTarget:self action:@selector(buttonCategoryPress:) forControlEvents:1 << 6];

		tagValue++;

		CGRect frame = cell.frame;
		frame.origin.y = yPosition;
		cell.frame = frame;

		yPosition += frame.size.height;
		[self.scrollViewCategory addSubview:cell];
	}

	[self reloadProductsForCategoryAtIndex:0];
	[self.scrollViewCategory setContentSize:CGSizeMake(self.scrollViewCategory.frame.size.width, yPosition)];

	[self.scrollViewCategory setContentInset:UIEdgeInsetsZero];
	[self.scrollViewCategory setContentOffset:CGPointZero];

	[self.scrollViewCategory setScrollIndicatorInsets:UIEdgeInsetsZero];
}

- (void)reloadProductsForCategoryAtIndex:(NSInteger)index
{
	if (self.categoryList.count == 0)
		return;

	self.selectedCategory = [self.categoryList objectAtIndex:index];
	self.selectedFoods = self.selectedCategory.arrayOfFoods;

	[UIView transitionWithView:self.labelCategoryName duration:kDefaultAnimationDuration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
	  [self.labelCategoryName setText:self.selectedCategory.strCategoryName];
	} completion:nil];

	[self.tableViewProducts beginUpdates];
	[self.tableViewProducts reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
	[self.tableViewProducts endUpdates];
}

- (void)beforeDisplayingProductCell:(id)cell
{
}

#pragma mark --- Button Action

- (IBAction)buttonCategoryPress:(id)sender
{
	UIView *view = [self.scrollViewCategory viewWithTag:[sender tag] + kDefaultImageTag];

	[UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	  view.transform = CGAffineTransformMakeScale(1.3, 1.3);
	} completion:^(BOOL finished) {
	  [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	    view.transform = CGAffineTransformMakeScale(1, 1);
		}];
	}];
	// animate button category
	[self reloadProductsForCategoryAtIndex:[sender tag]];
}

#pragma mark --- TableView Delegate and Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.selectedFoods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];

	if (!cell) {
		cell = LoadCell(@"ProductCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	FoodModel *foodModel = [self.selectedFoods objectAtIndex:indexPath.row];

	[cell.imageViewProduct setImageWithURL:[NSURL URLWithString:foodModel.strImage]];
	[cell.labelPrice setText:foodModel.strPrice];
	[cell.labelProductname setText:foodModel.strFoodName];
	[cell.labelQuantity setText:[NSString stringWithFormat:@"%@ %@", foodModel.strquantity, foodModel.strMeasuringUnit]];

	[cell.viewContainerOrder setTag:kDefaultViewMakeOrderTag + indexPath.row];
	[self beforeDisplayingProductCell:cell];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kProductCellHeight;
}

@end