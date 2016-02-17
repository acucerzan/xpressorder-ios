//
// OrderedFoodsVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 17/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "OrderedFoodsVC.h"
#import "OrderedFoodCell.h"

#import "FoodOrder.h"

@interface OrderedFoodsVC () <UITableViewDataSource, UITableViewDelegate>
{
	UITableView *tableViewOrder;
	NSArray *dataSource;
}

@end

@implementation OrderedFoodsVC

- (void)viewDidLoad
{
	[super viewDidLoad];

	dataSource = [NSArray new];

	CGRect frame = [UIScreen mainScreen].bounds;
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

		    [tableViewOrder beginUpdates];
		    [tableViewOrder reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
		    [tableViewOrder endUpdates];
			}
		}];
	}

	// Do any additional setup after loading the view.
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

	[cell.labelQuantity setText:foodOrder.foodOrderedQuantity];
	[cell.labelName setText:foodOrder.foodName];
	[cell.labelName setNumberOfLines:0];
	[cell.labelPrice setText:foodOrder.foodPrice];

	[cell.contentView setBackgroundColor:ClearColor];
	[cell setBackgroundColor:ClearColor];
	return cell;
}

@end