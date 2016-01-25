//
// ReviewCurrentVote.m
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReviewCurrentVoteCell.h"

@implementation ReviewCurrentVoteCell

- (void)awakeFromNib
{
	self.viewRating.minimumValue = 0;
	self.viewRating.maximumValue = 5;
	self.viewRating.allowsHalfStars = YES;
	self.viewRating.spacing = 1;
	self.viewRating.tintColor = XP_PURPLE;
	self.viewRating.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end