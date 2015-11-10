//
//  BaseViewController.h
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setTitleString:(NSString *)titleString;
- (void)loadBackButton;
- (void)popBack;

@end
