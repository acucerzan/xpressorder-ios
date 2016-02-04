//
// LeftMenuCell.h
// XpressOrder
//
// Created by Adrian Cucerzan on 22/09/14.
// Copyright (c) 2014 Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CafeReviewButton.h"

#define kPlaceCellHeight 110

@interface PlaceCell: UITableViewCell

- (CafeReviewButton *)reviewButton;
- (UIView *)viewSeparator;
- (void)loadItem:(Cafe *)item;

@property (weak, nonatomic) IBOutlet CafeReviewButton *buttonReservTable;
@property (weak, nonatomic) IBOutlet CafeReviewButton *buttonHistory;
@property (weak, nonatomic) IBOutlet CafeReviewButton *buttonMenu;

@property (weak, nonatomic) IBOutlet UIView *viewButtonsBase;
@property (weak, nonatomic) IBOutlet UIButton *buttonReview;

- (UIImageView *)placeImageView;

@end