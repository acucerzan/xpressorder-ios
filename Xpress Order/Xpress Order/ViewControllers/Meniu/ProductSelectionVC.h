//
//  ProductSelectionVC.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 20/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "BaseMenuVC.h"

@class Table;

@interface ProductSelectionVC : BaseMenuVC

@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

@end
