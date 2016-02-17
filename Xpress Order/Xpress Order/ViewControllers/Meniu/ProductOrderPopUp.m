//
// ProductOrderPopUp.m
// Xpress Order
//
// Created by Constantin Saulenco on 15/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ProductOrderPopUp.h"
#import "FoodModel.h"
#import "UIImageView+AFNetworking.h"

@interface ProductOrderPopUp ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHorizontal;

@end

@implementation ProductOrderPopUp

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
	[self.labelDetails setNumberOfLines:0];

	[self.viewContainer setBackgroundColor:[UIColor whiteColor]];

	UIImage *image = [XPUtils imageWithColor:XP_PURPLE andFrame:self.buttonOK.frame];
	[self.buttonOK setBackgroundImage:image forState:0];
	[self.buttonOK.layer setCornerRadius:3];
	[self.buttonOK setClipsToBounds:YES];

	[self.buttonAction setBackgroundImage:image forState:0];
	[self.buttonAction.layer setCornerRadius:3];
	[self.buttonAction setClipsToBounds:YES];

	[self.buttonAction setTitle:self.actionButtonTitle forState:0];

	[self.labelObservation setText:@"Observatii"];

	[self.textViewObservations setText:@""];
	[self.textViewObservations.layer setBorderWidth:1];
	[self.textViewObservations.layer setCornerRadius:3];
	[self.textViewObservations.layer setBorderColor:[[UIColor grayColor] CGColor]];

	[self addTapToQuit];

	// Register notification when the keyboard will be show
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillShow:)
	                                             name:UIKeyboardWillShowNotification
	                                           object:nil];

	// Register notification when the keyboard will be hide
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillHide:)
	                                             name:UIKeyboardWillHideNotification
	                                           object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.buttonAction setTitle:self.actionButtonTitle forState:0];
}

#pragma mark --- Keyboard Notification

#define kAnimationDuration .3
#define kDefaultDifference 10

- (void)keyboardWillShow:(NSNotification *)note
{
	// Get the keyboard size
	CGRect keyboardFrame = [[note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];

	CGFloat yBot = self.view.frame.size.height - keyboardFrame.size.height;

	CGFloat yContainerBot = self.viewContainer.frame.origin.y + self.viewContainer.frame.size.height;
	CGFloat difference = yContainerBot - yBot + kDefaultDifference;


	if (difference > 0) {
		self.constraintHorizontal.constant = -difference;
		[UIView animateWithDuration:kAnimationDuration animations:^{
		  [self.view layoutIfNeeded];
		}];
	}
}

- (void)keyboardWillHide:(NSNotification *)note
{
	self.constraintHorizontal.constant = 0;
	[UIView animateWithDuration:kAnimationDuration animations:^{
	  [self.view layoutIfNeeded];
	}];
}

- (IBAction)buttonOKPress:(id)sender
{
	[self.delegate productOrder:self dismissedWithOption:DismissOptionOk forFood:self.selectedFoodModel andObservation:self.textViewObservations.text];
}

- (IBAction)buttonActionPress:(id)sender
{
	[self.delegate productOrder:self dismissedWithOption:DismissOptionWithAction forFood:self.selectedFoodModel andObservation:self.textViewObservations.text];
}

@end