//
// PinPopUp.m
// Xpress Order
//
// Created by Constantin Saulenco on 08/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "PinPopUp.h"
#import "UITextField+Types.h"

@interface PinPopUp () <UITextFieldDelegate>

@end

@implementation PinPopUp

- (void)viewDidLoad
{
	[super viewDidLoad];

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


	[self.textFieldPin setReturnKeyType:UIReturnKeyDone];
	[self.textFieldPin setDelegate:self];
	[self.textFieldPin setTextFieldType:TextFieldTypeAlpaNumerical];
	[self.textFieldPin setMaxLength:4];
	[self.textFieldPin setText:@""];
	[self.textFieldPin setPlaceholder:@"****"];

	[self addTapToQuit];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	return [textField textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.view endEditing:YES];
	return YES;
}

#pragma mark --- buttonAction
- (IBAction)buttonSendPress:(id)sender
{
    [self.delegate pinPopup:self dissmissedWithCode:self.textFieldPin.text forTable:self.selectedTable];
}

@end