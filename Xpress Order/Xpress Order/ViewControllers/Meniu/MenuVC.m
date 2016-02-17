//
// MenuVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 11/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "MenuVC.h"

@interface MenuVC () <ProductDetailProtocol>

@property (weak, nonatomic) IBOutlet UIView *viewLabelBase;

@end

@implementation MenuVC

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.viewLabelBase.layer setShadowColor:[[UIColor blackColor] CGColor]];
	[self.viewLabelBase.layer setShadowOpacity:.2];
	[self.viewLabelBase.layer setShadowOffset:CGSizeMake(0, 5)];

	[self setTitleString:@"Meniu"];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)beforeDisplayingProductCell:(ProductCell *)cell
{
	[cell setProductCellType:ProductCellTypeNonOrder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	FoodModel *foodModel = [self.selectedFoods objectAtIndex:indexPath.row];
	ProductDetailPopUp *popUp = [[ProductDetailPopUp alloc] initWithNibName:@"ProductDetailPopUp" andFoodModel:foodModel];

	[popUp setActionButtonTitle:@"Mese"];

	popUp.delegate = self;
	[popUp showPopUpInViewController:self];
}

- (void)productDetail:(ProductDetailPopUp *)popUp dismissedWithOption:(DismissOption)option forFood:(FoodModel *)food
{
	if (option == DismissOptionOk)
		[popUp closePopUp];
	else
		if (option == DismissOptionWithAction) {
			[popUp closePopUp];

			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				// go to table VC
				[[NSNotificationCenter defaultCenter] postNotificationName:kGoToTableScreen object:nil];
				[self.navigationController popViewControllerAnimated:YES];
			});
		}
}

@end