//
// OrderedFoodsVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 17/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "OrderedFoodsVC.h"
#import "OrderedFoodCell.h"

#import "TotalPayCell.h"
#import "FoodOrder.h"

@interface OrderedFoodsVC () <UITableViewDataSource, UITableViewDelegate>
{
	UITableView *tableViewOrder;
	NSArray *dataSource;
	NSMutableArray *selectedIndexes;
	TotalPayCell *cellTotal;
}

- (void)animateImageView:(UIImageView *)imageView withImageName:(NSString *)imageName;

@end

@implementation OrderedFoodsVC

- (void)viewDidLoad
{
	[super viewDidLoad];

	dataSource = [NSArray new];
	selectedIndexes = [NSMutableArray new];
	[self setTitleString:@"Comada"];

	CGRect frame = [UIScreen mainScreen].bounds;
	frame.size.height -= kTotalPayCellHeight;

	UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
	[imageView setImage:Image(@"bg_texture")];
	[self.view addSubview:imageView];

	tableViewOrder = [[UITableView alloc] initWithFrame:frame];
	[tableViewOrder setDelegate:self];
	[tableViewOrder setDataSource:self];

	[tableViewOrder setSeparatorStyle:UITableViewCellSeparatorStyleNone];

	[self.view addSubview:tableViewOrder];

	[tableViewOrder setBackgroundColor:[UIColor clearColor]];
	[tableViewOrder setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];

	XPModel *shared = [XPModel sharedInstance];

	if (shared.tableAccess) {
		[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

		MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
		[networkingDataSource getFoodOrderForOrderId:shared.tableAccess.orderID withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
		  [SVProgressHUD dismiss];
		  if (!error) {
		    NSLog(@"Ordered foods %@", items);
		    dataSource = items;
		    for (int i = 0; i < dataSource.count; i++)
					[selectedIndexes addObject:[NSNumber numberWithBool:YES]];

		    [UserDefaultsManager setOrderedFoodArray:dataSource forPlace:shared.selectedCafe];

		    NSInteger value = [self totalPaymentValue];
		    [cellTotal.labelTotalValue setText:[NSString stringWithFormat:@"%d", (int) value]];

		    [tableViewOrder beginUpdates];
		    [tableViewOrder reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
		    [tableViewOrder endUpdates];
			}
		}];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	CGRect frame = [UIScreen mainScreen].bounds;
	frame.size.height -= kTotalPayCellHeight;

	// add total cell
	cellTotal = LoadCell(@"TotalPayCell");

	CGRect cellFrame = cellTotal.frame;
	cellFrame.origin.y = frame.size.height;
	[cellTotal setFrame:cellFrame];

	[self.view addSubview:cellTotal];
}

- (NSInteger)totalPaymentValue
{
	NSInteger total = 0;
	for (int i = 0; i < selectedIndexes.count; i++)
		if ([[selectedIndexes objectAtIndex:i] boolValue]) {
			FoodOrder *model = [dataSource objectAtIndex:i];
			NSInteger value = [model.foodPrice integerValue];
			total += value;
		}

	return total;
}

- (void)viewWillLayoutSubviews
{
	CGRect frame = cellTotal.frame;
	frame.size.width = self.view.frame.size.width;

	[cellTotal setFrame:frame];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark --- UItableviewData Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	OrderedFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderedFoodCell"];
	if (!cell) {
		cell = LoadCell(@"OrderedFoodCell");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	FoodOrder *foodOrder = [dataSource objectAtIndex:indexPath.row];

	[cell.labelQuantity setText:[NSString stringWithFormat:@"%@x", foodOrder.foodOrderedQuantity]];
	[cell.labelName setText:foodOrder.foodName];
	[cell.labelName setNumberOfLines:0];
	[cell.labelPrice setText:foodOrder.foodPrice];

	if ([[selectedIndexes objectAtIndex:indexPath.row] boolValue] == YES)
		[cell.imageViewCheck setImage:Image(@"checkbox_grey_checked")];
	else
		[cell.imageViewCheck setImage:Image(@"checkbox_grey")];

	[cell.contentView setBackgroundColor:ClearColor];
	[cell setBackgroundColor:ClearColor];
	return cell;
}

#pragma mark --- UItablewView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL value = [[selectedIndexes objectAtIndex:indexPath.row] boolValue];
	value = !value;
	[selectedIndexes replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:value]];

	OrderedFoodCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	if (value)
		[self animateImageView:cell.imageViewCheck withImageName:@"checkbox_grey_checked"];

	else
		[self animateImageView:cell.imageViewCheck withImageName:@"checkbox_grey"];

	NSInteger total = [self totalPaymentValue];
	[cellTotal.labelTotalValue setText:[NSString stringWithFormat:@"%d", (int) total]];
}

- (void)animateImageView:(UIImageView *)imageView withImageName:(NSString *)imageName
{
	[UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	  imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
	} completion:^(BOOL finished) {
	  [imageView setImage:Image(imageName)];
	  [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	    imageView.transform = CGAffineTransformMakeScale(1, 1);
		}];
	}];
}

@end