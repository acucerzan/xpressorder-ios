//
// OrderedHistory.h
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOrderedHistoryHeight 50;

@interface OrderedHistory: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;

@end