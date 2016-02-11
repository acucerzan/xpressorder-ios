//
// ProductDetailPopUp.m
// Xpress Order
//
// Created by Constantin Saulenco on 11/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ProductDetailPopUp.h"
#import "FoodModel.h"
#import "UIImageView+AFNetworking.h"

@interface ProductDetailPopUp ()

@end

@implementation ProductDetailPopUp

- (instancetype)initWithNibName:(NSString *)nibName andFoodModel:(FoodModel *)foodModel
{
	self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
	if (self)
		self.selectedFoodModel = foodModel;


	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.imageViewProduct setImageWithURL:[NSURL URLWithString:self.selectedFoodModel.strImage]];

	NSString *text = self.selectedFoodModel.strNote;
	if (text.length == 0)
		text = self.selectedFoodModel.strFoodName;

	[self.labelDetails setText:text];
	[self.labelDetails setTextAlignment:NSTextAlignmentCenter];
	[self.labelDetails setTextColor:XP_PURPLE];
	[self.labelDetails setFont:MainFontRegular(24)];


	[self.viewContainer setBackgroundColor:[UIColor whiteColor]];

	UIImage *image = [XPUtils imageWithColor:XP_PURPLE andFrame:self.buttonOK.frame];
	[self.buttonOK setBackgroundImage:image forState:0];
	[self.buttonOK.layer setCornerRadius:3];
	[self.buttonOK setClipsToBounds:YES];

	[self.buttonGoToTables setBackgroundImage:image forState:0];
	[self.buttonGoToTables.layer setCornerRadius:3];
	[self.buttonGoToTables setClipsToBounds:YES];


	[self addTapToQuit];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (IBAction)buttonOKPress:(id)sender
{
	[self.delegate productDetail:self dismissedWithOption:DismissOptionOk];
}

- (IBAction)buttonGoToTables:(id)sender
{
	[self.delegate productDetail:self dismissedWithOption:DismissOptionGoToTables];
}

@end