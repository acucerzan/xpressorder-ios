//
// OrderedHistory.m
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "OrderedHistory.h"

@implementation OrderedHistory

- (void)awakeFromNib
{
	[self.labelPrice setTextColor:[UIColor whiteColor]];
	[self.labelPrice setFont:MainFontRegular(16)];

	[self.labelQuantity setTextColor:[UIColor whiteColor]];
	[self.labelQuantity setFont:MainFontRegular(16)];

	[self.labelName setTextColor:[UIColor whiteColor]];
	[self.labelName setFont:MainFontRegular(16)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end