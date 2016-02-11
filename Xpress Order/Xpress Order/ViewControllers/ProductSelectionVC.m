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

@interface ProductSelectionVC ()


@end

@implementation ProductSelectionVC


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

@end