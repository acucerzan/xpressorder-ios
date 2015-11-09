//
//  TableSelectionVC.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 09/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cafe;
@interface TableSelectionVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableViewTableSelection;
@property (nonatomic, strong) Cafe *cafe;

@end
