//
// ReservationImageCell.h
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kReservationImageCellHeight 160

@interface ReservationImageCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPlace;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@end