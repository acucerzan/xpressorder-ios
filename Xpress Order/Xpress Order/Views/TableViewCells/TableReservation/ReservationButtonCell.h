//
// ReservationButton.h
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kReservationButtonCellHeight 44

@interface ReservationButtonCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewTopSeparator;
@property (weak, nonatomic) IBOutlet UIView *viewBottomSeparator;

- (void)setSeparatorsHidden:(BOOL)hidden;

@end