//
//  ReservationNameCell.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 20/01/16.
//  Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "ReservationNameCell.h"

@implementation ReservationNameCell

- (void)awakeFromNib {

    [self.textField setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.20]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
