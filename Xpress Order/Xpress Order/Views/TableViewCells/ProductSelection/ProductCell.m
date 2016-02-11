//
// ProductCell.m
// Xpress Order
//
// Created by Constantin Saulenco on 20/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "ProductCell.h"

@interface ProductCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsButtonOrderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonOrderBottom;


@end
@implementation ProductCell

- (void)awakeFromNib
{
	[self.viewContainerOrder.layer setCornerRadius:3];
	[self.viewContainerOrder.layer setBorderWidth:1];
	[self.viewContainerOrder.layer setBorderColor:[XP_PURPLE CGColor]];

	[self.viewLabelSeparator setBackgroundColor:XP_PURPLE];

	[self.viewContainerOrder setBackgroundColor:[UIColor whiteColor]];
    
	[self.labelPrice setBackgroundColor:ClearColor];
    [self.labelPrice setTextAlignment:NSTextAlignmentCenter];
    [self.labelPrice setTextColor:XP_PURPLE];
    [self.labelPrice setFont:MainFontBold(20)];
    
	[self.labelQuantity setBackgroundColor:ClearColor];
    [self.labelQuantity setTextAlignment:NSTextAlignmentCenter];
    [self.labelQuantity setTextColor:XP_PURPLE];
    [self.labelQuantity setFont:MainFontRegular(18)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)setProductCellType:(ProductCellType)productCellType
{
	if (productCellType == ProductCellTypeNonOrder) {
		self.constraintsButtonOrderHeight.constant = 0;
		self.constraintButtonOrderBottom.constant = 0;
		[self.buttonOrder setHidden:YES];
	}
}

@end