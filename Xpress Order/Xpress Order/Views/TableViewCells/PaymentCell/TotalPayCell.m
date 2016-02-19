//
// TotalPayCell.m
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "TotalPayCell.h"

@implementation TotalPayCell

- (void)awakeFromNib
{
	[self setBackgroundColor:XP_LIGHTPURPLE];

	[self.labelTotal setTextColor:[UIColor whiteColor]];
	[self.labelTotal setFont:MainFontRegular(20)];

	[self.labelTotalValue setTextColor:[UIColor whiteColor]];
	[self.labelTotalValue setFont:MainFontBold(25)];

	[self.labelAchita setBackgroundColor:XP_PURPLE];
	[self.labelAchita setTextColor:[UIColor whiteColor]];
	[self.labelAchita setFont:MainFontRegular(20)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end