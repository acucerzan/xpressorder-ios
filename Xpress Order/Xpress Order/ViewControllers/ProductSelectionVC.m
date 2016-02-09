//
// ProductSelectionVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 20/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "ProductSelectionVC.h"
#import "Table.h"

#import "ProductGroupCell.h"
#import "ProductCell.h"

#import "CategoryModel.h"
#import "FoodModel.h"

@interface ProductSelectionVC () <UITableViewDataSource, UITableViewDelegate>
{
	Table *selectedTable;

	NSArray <CategoryModel *> *categoryList;

	CategoryModel *selectedCategory;
	NSArray <FoodModel *> *selectedFoods;

	__weak IBOutlet UIScrollView *scrollViewCategory;
	__weak IBOutlet UITableView *tableViewProducts;
}

@end

@implementation ProductSelectionVC

- (instancetype)initWithSelectedTable:(Table *)table
{
	self = [self init];
	if (self) {
		selectedTable = table;
		[self menuForCurrentTable];
		// download menu and stuff
	}
	return self;
}

- (instancetype)init
{
	self = [super initWithNibName:@"ProductSelectionVC" bundle:[NSBundle mainBundle]];
	if (self) {
		// get network data
	}

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
	self.title = @"Back";
	[self setTitleString:@"Select desire products"];

	UIButton *buttonOption = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonOption setFrame:CGRectMake(0, 0, 40, 40)];
	[buttonOption addTarget:self action:@selector(buttonOptionPress:) forControlEvents:1 << 6];
// [buttonOption setTitle:@"Option" forState:0];
	[buttonOption setImage:Image(@"settings") forState:0];

	UIBarButtonItem *barButtonOption = [[UIBarButtonItem alloc] initWithCustomView:buttonOption];

	UIButton *buttonBill = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonBill setFrame:CGRectMake(0, 0, 40, 40)];
	[buttonBill addTarget:self action:@selector(buttonBillPress:) forControlEvents:1 << 6];
// [buttonBill setTitle:@"Bill" forState:0];
	[buttonBill setImage:Image(@"pay") forState:0];

	UIBarButtonItem *barButtonBill = [[UIBarButtonItem alloc] initWithCustomView:buttonBill];

	UIButton *buttonMenu = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonMenu setFrame:CGRectMake(0, 0, 40, 40)];
	[buttonMenu addTarget:self action:@selector(buttonMenuPress:) forControlEvents:1 << 6];
	[buttonMenu setImage:Image(@"menu") forState:0];

// [buttonMenu setTitle:@"Menu" forState:0];
	UIBarButtonItem *barButtonMenu = [[UIBarButtonItem alloc] initWithCustomView:buttonMenu];

	[self.navigationItem setRightBarButtonItems:@[barButtonOption, barButtonBill, barButtonMenu]];

	self.edgesForExtendedLayout = UIRectEdgeNone;
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

#pragma mark --- BUtton Action

- (IBAction)buttonOptionPress:(id)sender
{
}

- (IBAction)buttonBillPress:(id)sender
{
}

- (IBAction)buttonMenuPress:(id)sender
{
}

- (IBAction)buttonCategoryPress:(id)sender
{
	[self reloadProductsForCategoryAtIndex:[sender tag]];
}

#pragma mark --- TableView Delegate and Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return selectedFoods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];

	if (!cell) {
		cell = LoadCell(@"ProductCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	FoodModel *foodModel = [selectedFoods objectAtIndex:indexPath.row];

	[cell.imageViewProduct setImageWithURL:[NSURL URLWithString:foodModel.strImage]];
	[cell.labelPrice setText:foodModel.strPrice];
	[cell.labelProductname setText:foodModel.strFoodName];
	[cell.labelQuantity setText:[NSString stringWithFormat:@"%@ %@", foodModel.strquantity, foodModel.strMeasuringUnit]];

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kProductCellHeight;
}

#pragma mark --- helperFunctions

- (void)populateCategoryView
{
	int yPosition = 0;
	int tagValue = 0;
	for (CategoryModel *categ in categoryList) {
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
		[scrollViewCategory addSubview:cell];
	}

	[self reloadProductsForCategoryAtIndex:0];
	[scrollViewCategory setContentSize:CGSizeMake(scrollViewCategory.frame.size.width, yPosition)];
}

- (void)reloadProductsForCategoryAtIndex:(NSInteger)index
{
	selectedCategory = [categoryList objectAtIndex:index];
	selectedFoods = selectedCategory.arrayOfFoods;

	[self.labelCategoryName setText:selectedCategory.strCategoryName];

	[tableViewProducts reloadData];
}

#pragma mark --- Network place

- (void)menuForCurrentTable
{
	MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];

	[networkingDataSource getCategoryFoodforPlaceID:selectedTable.place_id andTableNumber:selectedTable.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  if (!error) {
	    categoryList = items;
	    [self populateCategoryView];
		}
	}];
}

@end