//
// ProductSelectionVC.m
// Xpress Order
//
// Created by Constantin Saulenco on 20/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "ProductSelectionVC.h"
#import "Table.h"

#import "CategoryModel.h"
#import "FoodModel.h"

@interface ProductSelectionVC () <ProductDetailProtocol, UISearchBarDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *viewSearchBar;


@end

@implementation ProductSelectionVC


- (void)viewDidLoad
{
	[super viewDidLoad];

	self.automaticallyAdjustsScrollViewInsets = NO;

	[self.viewSearchBar.layer setShadowColor:[[UIColor blackColor] CGColor]];
	[self.viewSearchBar.layer setShadowOpacity:.2];
	[self.viewSearchBar.layer setShadowOffset:CGSizeMake(0, 5)];

	[self.navigationController.navigationBar setTranslucent:YES];

	// set the search bar
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
	[self.searchBar setDelegate:self];

	// set label category name
	[self.labelCategoryName setTextColor:[UIColor whiteColor]];

	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
	self.title = @"Back";
	[self setTitleString:@"Meniu"];

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

	[self.navigationItem setRightBarButtonItems:@[barButtonOption, barButtonBill]];

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

- (void)beforeDisplayingProductCell:(ProductCell *)cell
{
	[cell setProductCellType:ProductCellTypeOrder];

// UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc] init];
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewMakeOrderPress:)];
	[tapGesture setDelegate:self];
	[cell.viewContainerOrder addGestureRecognizer:tapGesture];
}

#pragma mark --- Gesture recognizer Delegate
// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing
// this touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	UIView *view = touch.view;
	if ([view.superview.superview isKindOfClass:[UITableViewCell class]]) {
		[UIView animateWithDuration:kDefaultAnimationDuration animations:^{
		  view.transform = CGAffineTransformMakeScale(1.1, 1.1);
		  [view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.12]];
		}];
	}
	return YES;
}

#pragma mark --- HelperFunctions

- (IBAction)viewMakeOrderPress:(id)sender
{
	UIView *view = [sender view];

	[UIView animateWithDuration:kDefaultAnimationDuration animations:^{
	  view.transform = CGAffineTransformMakeScale(1, 1);
	  [view setBackgroundColor:[UIColor whiteColor]];
	}];

	NSInteger index = [view tag] - kDefaultViewMakeOrderTag;
	if (index <= self.selectedFoods.count - 1) {
		FoodModel *foodModel = [self.selectedFoods objectAtIndex:index];
		[self makeOrderForFood:foodModel];
	}
}

- (void)makeOrderForFood:(FoodModel *)food
{
	NSLog(@"make an order press");
}

#pragma mark --- tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	FoodModel *foodModel = [self.selectedFoods objectAtIndex:indexPath.row];
	ProductDetailPopUp *popUp = [[ProductDetailPopUp alloc] initWithNibName:@"ProductDetailPopUp" andFoodModel:foodModel];
	popUp.delegate = self;
	popUp.actionButtonTitle = @"Comanda";
	[popUp.buttonAction setTitle:@"Comanda" forState:0];

	[popUp showPopUpInViewController:self];
}

- (void)productDetail:(ProductDetailPopUp *)popUp dismissedWithOption:(DismissOption)option forFood:(FoodModel *)food
{
	if (option == DismissOptionOk)
		[popUp closePopUp];
	else
		if (option == DismissOptionWithAction) {
			[popUp closePopUp];
			[self makeOrderForFood:food];
		}
}

#pragma mark --- BUtton Action

- (IBAction)buttonOptionPress:(id)sender
{
	XPModel *shared = [XPModel sharedInstance];
	NSString *message = [NSString stringWithFormat:@"Pinul dumneavoastra este : %@ !", shared.tableAccess.pinCode];
	MakeAlert(@"Info", message);
}

- (IBAction)buttonBillPress:(id)sender
{
}

#pragma mark --- Search bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if (searchText.length == 0) {
		self.categoryList = self.originalCategoryList;
		[self reloadScrollView];
	}
	NSLog(@"text did change");
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	[self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	[self.searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.view endEditing:YES];

	NSMutableArray *newFilteredArray = [NSMutableArray new];

	for (CategoryModel *category in self.originalCategoryList) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"strFoodName CONTAINS[cd] %@", searchBar.text];
		NSArray *filtered = [category.arrayOfFoods filteredArrayUsingPredicate:predicate];

		if (filtered.count != 0) {
			CategoryModel *newModel = [[CategoryModel alloc] initWithModel:category andFoodArray:filtered];
			[newFilteredArray addObject:newModel];
		}
	}

	self.categoryList = newFilteredArray;
	[self reloadScrollView];
// [self.tableViewProducts reloadData];

	NSLog(@"search bar button pressed");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	// cancel search add original
	[self.view endEditing:YES];

// self.categoryList = self.originalCategoryList;
// [self reloadScrollView];

	NSLog(@"search bar button cancel press");
}

@end