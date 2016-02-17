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

@property (weak, nonatomic) IBOutlet UILabel *labelTableName;
@property (weak, nonatomic) IBOutlet UILabel *labelTableNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelPersonNumber;

@property (weak, nonatomic) IBOutlet UILabel *labelState;
@property (weak, nonatomic) IBOutlet UILabel *labelDetails;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPin;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHorizontal;

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

	NSString *tableName = @"Masa";
	if (!self.selectedTable.isTable)
		tableName = @"Bar";

	[self.labelTableName setText:tableName];
	[self.labelTableNumber setText:self.selectedTable.place_id];
	[self.labelPersonNumber setText:[NSString stringWithFormat:@"x%@", self.selectedTable.user_available]];

	NSString *tableState = @"Liber";
	if (self.selectedTable.tableState == TableStateBusy)
		tableState = @"Ocupat";
	else
		if (self.selectedTable.tableState == TableStateReserved)
			tableState = @"Rezervat";

	[self.labelState setText:tableState];
	[self.labelState setTextColor:XP_PURPLE];

	[self.labelDetails setText:@"pentru moment, insereaza pinul pentru aceasta masa sau gaseste o alta masa."];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.5 * NSEC_PER_SEC)), mainThread, ^{
		[self.textFieldPin becomeFirstResponder];
	});
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
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