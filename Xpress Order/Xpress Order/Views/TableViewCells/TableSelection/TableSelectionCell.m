//
// TableSelectionCell.m
// Xpress Order
//
// Created by Constantin Saulenco on 09/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableSelectionCell.h"
#import "Table.h"

@implementation TableSelectionCell
{
	Table *leftTable;
	Table *rightTable;
}

- (void)awakeFromNib
{
	// Initialization code
	[self.imageViewLeftTable.layer setCornerRadius:self.imageViewLeftTable.frame.size.height / 2];
// [self.viewLeftTableNumber.layer setCornerRadius:self.viewLeftTableNumber.frame.size.height / 2];
// [self.viewLeftTableState.layer setCornerRadius:self.viewLeftTableState.frame.size.height / 2];
	[self.imageViewLeftTable setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.10]];

	[self.imageViewRightTable.layer setCornerRadius:self.imageViewRightTable.frame.size.height / 2];
// [self.viewRightTableState.layer setCornerRadius:self.viewRightTableState.frame.size.height / 2];
// [self.viewRightTableNumber.layer setCornerRadius:self.viewRightTableNumber.frame.size.height / 2];
	[self.imageViewRightTable setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.10]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

#pragma mark --- Helper Functions
// table state free/ reserved /Busy
- (void)refreshCell
{
	[self.viewContainerRightTable setHidden:NO];
	[self.viewContainerLeftTable setHidden:NO];
}

- (void)setLeftTableViewWithTable:(Table *)table
{
	leftTable = table;

	NSString *tableName = kTableName;
	if (!table.isTable)
		tableName = kBarTName;

	[self.labelLeftTable setText:tableName];
	[self.labelLeftTable setTextColor:[UIColor whiteColor]];

	NSString *imageTableState = @"";
	NSString *imageTableView = @"free_table";
	NSString *imagePersonNumber = @"number_of_ppl_purple";

	NSString *tableState = @"";
	[self.viewLeftTableState setHidden:YES];

	if (leftTable.tableState == TableStateBusy) {
		imageTableView = @"grey_table_big";
		imagePersonNumber = @"number_of_ppl_purple";
		imageTableState = @"busy_or_reserved";

		tableState = @"ocupat";
		[self.viewLeftTableState setHidden:NO];
	}
	else
		if (leftTable.tableState == TableStateReserved) {
			imageTableView = @"table_busy";
			imagePersonNumber = @"number_of_ppl_purple";
			imageTableState = @"busy_or_reserved";

			tableState = @"R";
			[self.viewLeftTableState setHidden:NO];
		}


	[self.labelLeftPersonsNumber setText:[NSString stringWithFormat:@"x%@", table.user_available]];
	[self.labelLeftTableNumber setText:table.table_id];
	[self.labelLeftTableNumber setTextColor:[UIColor whiteColor]];

	[self.labelLeftTableState setText:tableState];
	[self.labelLeftTableState setTextColor:[UIColor whiteColor]];

	[self.imageViewLeftPersonNumer setImage:Image(imagePersonNumber)];
	[self.imageViewLeftTable setImage:Image(imageTableView)];
	[self.imageViewLeftTableState setImage:Image(imageTableState)];


	[self.viewContainerLeftTable setBackgroundColor:ClearColor];
	[self.viewLeftTableNumber setBackgroundColor:ClearColor];
	[self.viewLeftTableState setBackgroundColor:ClearColor];
	[self.viewLeftTable setBackgroundColor:ClearColor];
}

- (void)setRightTableViewWithTable:(Table *)table
{
	rightTable = table;

	NSString *tableName = @"Masa";
	if (!table.isTable)
		tableName = @"Bar";

	[self.labelRightTable setText:tableName];
	[self.labelRightTable setTextColor:[UIColor whiteColor]];


	// let's suppose that all tables are free
	NSString *imageTableState = @"";
	NSString *imageTableView = @"free_table";
	NSString *imagePersonNumber = @"number_of_ppl_purple";


	NSString *tableState = @"";
	[self.viewLeftTableState setHidden:YES];

	// table is busy = ocupat
	if (rightTable.tableState == TableStateBusy) {
		imageTableView = @"grey_table_big";
		imagePersonNumber = @"number_of_ppl_purple";
		imageTableState = @"busy_or_reserved";

		tableState = @"ocupat";
		[self.viewLeftTableState setHidden:NO];
	}
	else // if is table reserved
		if (rightTable.tableState == TableStateReserved) {
			imageTableView = @"table_busy";
			imagePersonNumber = @"number_of_ppl_purple";
			imageTableState = @"busy_or_reserved";

			tableState = @"R";
			[self.viewLeftTableState setHidden:NO];
		}


	[self.labelRightPersonsNumber setText:[NSString stringWithFormat:@"x%@", table.user_available]];
	[self.labelRightTableNumber setText:table.table_id];
	[self.labelRightTableNumber setTextColor:[UIColor whiteColor]];
	[self.labelRightTableState setText:tableState];
	[self.labelRightTableState setTextColor:[UIColor whiteColor]];

	[self.imageViewRightPersonNumber setImage:Image(imagePersonNumber)];
	[self.imageViewRightTable setImage:Image(imageTableView)];
	[self.imageViewRightTableState setImage:Image(imageTableState)];


	[self.viewContainerRightTable setBackgroundColor:ClearColor];
	[self.viewRightTableNumber setBackgroundColor:ClearColor];
	[self.viewRightTableState setBackgroundColor:ClearColor];
	[self.viewRightTable setBackgroundColor:ClearColor];
}

- (IBAction)buttonLeftTablePress:(id)sender
{
	if (self.buttonTablePress)
		self.buttonTablePress(leftTable);
}

- (IBAction)buttonRightTablePress:(id)sender
{
	self.buttonTablePress(rightTable);
}

@end