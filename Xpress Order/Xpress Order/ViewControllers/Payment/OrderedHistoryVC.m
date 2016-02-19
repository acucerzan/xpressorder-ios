//
// OrderedHistoryVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "OrderedHistoryVC.h"

#import "OrderedHistory.h"
#import "OrderedHistoryTotal.h"

#import "FoodOrder.h"

@interface OrderedHistoryVC () <UITableViewDataSource, UITableViewDelegate>
{
	UITableView *tableViewOrder;
	NSArray *dataSource;
	OrderedHistoryTotal *cellTotal;
	Cafe *selectedPlace;
}

@end

@implementation OrderedHistoryVC

- (instancetype)initWithPlace:(Cafe *)param
{
	self = [super init];
	if (self) {
		selectedPlace = param;
		dataSource = [UserDefaultsManager orderedFoodForPlace:param];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

// dataSource = [NSArray new];
	[self setTitleString:@"Ultima nota de plata"];

	CGRect frame = [UIScreen mainScreen].bounds;
	frame.size.height -= kOrderedHistoryTotalHeight;

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
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	CGRect frame = [UIScreen mainScreen].bounds;
	frame.size.height -= kOrderedHistoryTotalHeight;

	// add total cell
	cellTotal = LoadCell(@"OrderedHistoryTotal");

	CGRect cellFrame = cellTotal.frame;
	cellFrame.origin.y = frame.size.height;
	cellFrame.size.height = kOrderedHistoryTotalHeight;
	[cellTotal setFrame:cellFrame];

	[self.view addSubview:cellTotal];

	NSInteger value = [self totalPaymentValue];
	[cellTotal.labelTotalValue setText:[NSString stringWithFormat:@"%d", (int) value]];
}

- (NSInteger)totalPaymentValue
{
	NSInteger total = 0;
	for (int i = 0; i < dataSource.count; i++) {
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
	OrderedHistory *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderedHistory"];
	if (!cell) {
		cell = LoadCell(@"OrderedHistory");
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}

	FoodOrder *foodOrder = [dataSource objectAtIndex:indexPath.row];

	[cell.labelQuantity setText:[NSString stringWithFormat:@"%@x", foodOrder.foodOrderedQuantity]];
	[cell.labelName setText:foodOrder.foodName];
	[cell.labelName setNumberOfLines:0];
	[cell.labelPrice setText:foodOrder.foodPrice];

	[cell.contentView setBackgroundColor:ClearColor];
	[cell setBackgroundColor:ClearColor];
	return cell;
}

@end