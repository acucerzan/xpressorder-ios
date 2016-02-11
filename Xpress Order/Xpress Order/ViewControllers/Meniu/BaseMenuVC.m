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
	MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];

	[networkingDataSource getCategoryFoodforPlaceID:table.place_id andTableNumber:table.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  if (!error) {
	    self.categoryList = items;
	    [self populateCategoryView];
		}
	}];
}

#pragma mark --- helperFunctions

- (void)populateCategoryView
{
	int yPosition = 0;
	int tagValue = 0;
	for (CategoryModel *categ in self.categoryList) {
		ProductGroupCell *cell = LoadCell(@"ProductGroupCell");
		[cell.labelCategory setText:categ.strCategoryName];
		[cell imageFromURLString:categ.imgCategoryLogo];
		[cell setBackgroundColor:ClearColor];

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

	[self.labelCategoryName setText:self.selectedCategory.strCategoryName];

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

	[self beforeDisplayingProductCell:cell];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kProductCellHeight;
}

@end