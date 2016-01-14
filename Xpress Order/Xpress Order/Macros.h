//
// Macros.h
// Xpress Order
//
// Created by Constantin Saulenco on 29/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#define IS_IPAD          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_IPHONE_5      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6PLUS  (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_RETINA        ([[UIScreen mainScreen] scale] == 2.0)
#define IS_IOS8          ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.4)

#define SCREEN_SIZE      IS_IPAD ? IPAD_SCREEN_SIZE : ((double) [[UIScreen mainScreen] bounds].size.height)
#define IPAD_SCREEN_SIZE IS_IOS8 ? ((double) [[UIScreen mainScreen] bounds].size.height) : ((double) [[UIScreen mainScreen] bounds].size.width)

#define ClearColor               [UIColor clearColor]
#define RGB(r, g, b)             ([UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1])
#define RGBA(r, g, b, a)         ([UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a])
#define UIColorFromHEX(rgbValue) ([UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 \
	                                                green:((float) ((rgbValue & 0x00FF00) >> 8)) / 255.0 \
	                                                 blue:((float) ((rgbValue & 0x0000FF) >> 0)) / 255.0 \
	                                                alpha:1.0])

#define MainFontMedium(a)  ([UIFont fontWithName:@"HelveticaNeue-Medium" size:IS_IPHONE_6PLUS ? a : a - 2])
#define MainFontRegular(a) ([UIFont fontWithName:@"HelveticaNeue-Regular" size:IS_IPHONE_6PLUS ? a : a - 2])
#define MainFontBold(a)    ([UIFont fontWithName:@"HelveticaNeue-Bold" size:IS_IPHONE_6PLUS ? a : a - 2])

#define Image(a)                 ([UIImage imageNamed:a])
#define LoadCell(cellIdentifier) [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] objectAtIndex : 0];
#define LoadNib(nibName)         [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
#define mainThread               dispatch_get_main_queue()
#define globalThreadDefault      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// button functions
#define SetButtonAttributedTitle(BUTTON, TITLE) { [BUTTON setAttributedTitle:TITLE forState:UIControlStateNormal]; \
		                                              [BUTTON setAttributedTitle:TITLE forState:UIControlStateHighlighted]; \
		                                              [BUTTON setAttributedTitle:TITLE forState:UIControlStateSelected]; \
		                                              [BUTTON setAttributedTitle:TITLE forState:UIControlStateDisabled] }

#define SetButtonTitle(BUTTON, TITLE) { [BUTTON setTitle:TITLE forState:UIControlStateNormal]; \
		                                    [BUTTON setTitle:TITLE forState:UIControlStateHighlighted]; \
		                                    [BUTTON setTitle:TITLE forState:UIControlStateSelected]; \
		                                    [BUTTON setTitle:TITLE forState:UIControlStateDisabled]; }

#define SetButtonTitleColor(BUTTON, COLOR) { [BUTTON setTitleColor:COLOR forState:UIControlStateNormal]; \
		                                         [BUTTON setTitleColor:COLOR forState:UIControlStateHighlighted]; \
		                                         [BUTTON setTitleColor:COLOR forState:UIControlStateSelected]; \
		                                         [BUTTON setTitleColor:COLOR forState:UIControlStateDisabled]; }

#define SetButtonImage(BUTTON, imageName) { [BUTTON setExclusiveTouch:YES]; \
		                                        [BUTTON setImage:Image(imageName) forState:0]; \
		                                        [BUTTON setImage:Image([imageName stringByAppendingString:@"_pressed"]) forState:UIControlStateHighlighted]; \
		                                        [BUTTON setImage:Image([imageName stringByAppendingString:@"_pressed"]) forState:UIControlStateSelected]; }

#define SetButtonBackgroundImage(BUTTON, imageName) { \
		[BUTTON setExclusiveTouch:YES]; \
		[BUTTON setBackgroundImage:Image(imageName) forState:0]; \
		[BUTTON setBackgroundImage:Image([imageName stringByAppendingString:@"_pressed"]) forState:UIControlStateHighlighted]; \
		[BUTTON setBackgroundImage:Image([imageName stringByAppendingString:@"_pressed"]) forState:UIControlStateSelected]; }

#define SetBackgroundImageForButton(Button, imageName, selectedStateString) { \
		[Button setExclusiveTouch:YES]; \
		[Button setBackgroundImage:Image(imageName) forState:0]; \
		[Button setBackgroundImage:Image([imageName stringByAppendingString:selectedStateString]) forState:UIControlStateHighlighted]; \
		[Button setBackgroundImage:Image([imageName stringByAppendingString:selectedStateString]) forState:UIControlStateSelected]; }

#define SetButtonBlankBackgroundImage(BUTTON) { \
		[BUTTON setExclusiveTouch:YES]; \
		[BUTTON setBackgroundImage:nil forState:0]; \
		[BUTTON setBackgroundImage:nil forState:UIControlStateHighlighted]; \
		[BUTTON setBackgroundImage:nil forState:UIControlStateSelected]; }


#define MakeAlert(TITLE, MESSAGE) [[[UIAlertView alloc] initWithTitle:TITLE \
	                                                            message:MESSAGE \
	                                                           delegate:nil \
	                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil) \
	                                                  otherButtonTitles:nil] show]