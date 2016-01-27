//
// UITextField+Types.h
// Appointfix
//
// Created by Constantin on 22/01/16.
// Copyright © 2016 Mobiversal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, TextFieldType) {
	TextFieldTypeAlpaNumerical = 0,
	TextFieldTypeNumerical,
	TextFieldTypeCurrency,
	TextFieldTypeEmail,
};
@interface UITextField (Types) <UITextFieldDelegate>


@property (nonatomic, strong) NSString *decimalSymbol;
@property (nonatomic) NSInteger numberOfDigits;
@property (nonatomic) TextFieldType textFieldType;
@property (nonatomic) NSInteger maxLength;

#pragma mark --- TextFieldTypeNumerical
- (NSNumber *)numberFromTextField;

@end