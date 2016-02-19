//
// OrderedHistoryTotal.h
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOrderedHistoryTotalHeight 50

@interface OrderedHistoryTotal: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTotalValue;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@end