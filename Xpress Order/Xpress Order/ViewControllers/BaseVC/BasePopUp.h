//
// BasePopUp.h
// Xpress Order
//
// Created by Constantin Saulenco on 11/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSInteger, DismissOption) {
	DismissOptionOk = 0,
	DismissOptionWithAction
};

@interface BasePopUp: UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

- (void)showPopUpInViewController:(UIViewController *)viewController;
- (void)closePopUp;
- (void)addTapToQuit;

@end