//
// ReviewSetVoteCell.m
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReviewSetVoteCell.h"

@implementation ReviewSetVoteCell

- (void)awakeFromNib
{
	self.viewVote.minimumValue = 0;
	self.viewVote.maximumValue = 5;
	self.viewVote.allowsHalfStars = YES;
	self.viewVote.spacing = 1;
	self.viewVote.tintColor = XP_PURPLE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end