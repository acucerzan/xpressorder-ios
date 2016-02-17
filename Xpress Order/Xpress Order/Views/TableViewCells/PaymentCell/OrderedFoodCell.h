//
// OrderedFoodCell.h
// Xpress Order
//
// Created by Constantin Saulenco on 17/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOrderedFoodCellHeight 50

@interface OrderedFoodCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCheck;

@end