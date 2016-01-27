//
// UITextField+Types.m
// Appointfix
//
// Created by Constantin on 22/01/16.
// Copyright © 2016 Mobiversal. All rights reserved.
//

#import "UITextField+Types.h"
#import <objc/runtime.h>

#define kMaxNumberOfDigits     10
#define kMinNumberOfDigits     0
#define kDefaultNumberOfDigits 2

#define kDefaultMaxLength 20

static char const * const kMaxLength = "maxLength";
static char const * const kDecimalSymbol = "decimalSymbol";
static char const * const kNumberOfDigits = "numberOfDigits";
static char const * const kTextFieldType = "textFieldType";

@implementation UITextField (Types)

@dynamic maxLength;
@dynamic decimalSymbol;
@dynamic textFieldType;
@dynamic numberOfDigits;

#pragma mark --- get/set dynamic variables

- (void)setMaxLength:(NSInteger)newMaxLength
{
	objc_setAssociatedObject(self, kMaxLength, @(newMaxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxLength
{
	NSNumber *value = objc_getAssociatedObject(self, kMaxLength);
	if ([value integerValue] == 0)
		return kDefaultMaxLength;

	return [value integerValue];
}

- (void)setDecimalSymbol:(NSString *)newDecimalSymbol
{
	objc_setAssociatedObject(self, kDecimalSymbol, newDecimalSymbol, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)decimalSymbol
{
	NSString *value = objc_getAssociatedObject(self, kDecimalSymbol);
	if (value.length == 0)
		value = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
	return value;
}

- (void)setTextFieldType:(TextFieldType)newTextFieldType
{
	objc_setAssociatedObject(self, kTextFieldType, @(newTextFieldType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TextFieldType)textFieldType
{
	NSNumber *value = objc_getAssociatedObject(self, kTextFieldType);
	return (TextFieldType) [value integerValue];
}

- (void)setNumberOfDigits:(NSInteger)newNumberOfDigits
{
	NSInteger localvalue = newNumberOfDigits;

	if (newNumberOfDigits > kMaxNumberOfDigits || newNumberOfDigits < kMinNumberOfDigits)
		localvalue = kDefaultNumberOfDigits;
	else
		localvalue = newNumberOfDigits;

	objc_setAssociatedObject(self, kNumberOfDigits, @(localvalue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)numberOfDigits
{
	NSNumber *value = objc_getAssociatedObject(self, kNumberOfDigits);
	if ([value integerValue] == 0)
		return kDefaultNumberOfDigits;

	return [value integerValue];
}

#pragma mark --- TextFieldTypeNumerical

- (NSNumber *)numberFromTextField
{
	NSString *string = self.text;

	// if decimal symbol is @"." no replace is needed
	if (![self.decimalSymbol isEqualToString:@"."])
		string = [string stringByReplacingOccurrencesOfString:self.decimalSymbol withString:@"."];

	return [NSNumber numberWithFloat:[string floatValue]];
}

#define kAndSign @"@"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	// allow backspace
	if (!string.length)
		return YES;

	// if biggerThenMaxLength
	if (textField.text.length == self.maxLength)
		return NO;

	if (self.textFieldType == TextFieldTypeCurrency) {
		// for Decimal value start//////This code use use for allowing single decimal value

		// only one decimal symbol
		if ([textField.text rangeOfString:self.decimalSymbol].location == NSNotFound) {
			if ([string isEqualToString:self.decimalSymbol])
				return YES;
		}
		else
			if ([textField.text rangeOfString:self.decimalSymbol].location != NSNotFound && [string isEqualToString:self.decimalSymbol])
				return NO;
			else
				// limitate the number of decimal valuse
				if ([[textField.text substringFromIndex:[textField.text rangeOfString:self.decimalSymbol].location] length] > self.numberOfDigits)
					return NO;
	}

	if (self.textFieldType == TextFieldTypeNumerical)
		if (textField.text.length == 0 && [string isEqualToString:@"0"])
			return NO;


	if ((self.textFieldType == TextFieldTypeCurrency) || (self.textFieldType == TextFieldTypeNumerical)) {
		NSInteger intValue = [string intValue];

		if ((intValue >= 1 && intValue <= 9) || ([string isEqualToString:@"0"])) // -> because [@"a" intValue] = 0;
			// if string is not digit and string is not 0 then return NO
			return YES;
		else
			return NO;
	}

	if (self.textFieldType == TextFieldTypeEmail) {
		// only one decimal symbol
		if ([textField.text rangeOfString:kAndSign].location == NSNotFound) {
			if ([string isEqualToString:kAndSign])
				return YES;
		}
		else
			if ([textField.text rangeOfString:kAndSign].location != NSNotFound && [string isEqualToString:kAndSign])
				return NO;
	}
	return YES;
}

@end