//
//  DetailViewController.h
//  Xpress Order
//
//  Created by Adrian Cucerzan on 02/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

