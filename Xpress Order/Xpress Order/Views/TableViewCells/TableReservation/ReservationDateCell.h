//
// ReservationDateCell.h
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  kReservationDateCellHeight 200

@interface ReservationDateCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end