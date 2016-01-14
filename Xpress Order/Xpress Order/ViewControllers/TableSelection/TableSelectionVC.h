//
//  TableSelectionVC.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 09/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"


@interface TableSelectionVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableViewTableSelection;

- (instancetype) loadFromNibForPlace:(Cafe *)place;

@end
