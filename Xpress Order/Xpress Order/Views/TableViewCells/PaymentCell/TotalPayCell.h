//
// TotalPayCell.h
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTotalPayCellHeight 80

@interface TotalPayCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalValue;
@property (weak, nonatomic) IBOutlet UILabel *labelAchita;

@end