//
// ReviewCurrentVote.h
// Xpress Order
//
// Created by Constantin Saulenco on 20/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

#define kReviewCurrentVoteCellHeight 100

@interface ReviewCurrentVoteCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *viewRating;
@end