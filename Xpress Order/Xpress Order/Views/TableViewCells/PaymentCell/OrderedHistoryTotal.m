//
// OrderedHistoryTotal.m
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "OrderedHistoryTotal.h"

@implementation OrderedHistoryTotal

- (void)awakeFromNib
{
	[self setBackgroundColor:XP_LIGHTPURPLE];

	[self.labelTotal setTextColor:[UIColor whiteColor]];
	[self.labelTotal setFont:MainFontRegular(20)];

	[self.labelTotal setText:@"Total"];
	[self.labelTotalValue setTextColor:[UIColor whiteColor]];
	[self.labelTotalValue setFont:MainFontBold(25)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end