//
// ReservationNameCell.h
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kReservationNameCellHeight 75

@interface ReservationNameCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *viewSeparator;

@end