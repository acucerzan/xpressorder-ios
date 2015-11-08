//
//  LeftMenuCell.h
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/09/14.
//  Copyright (c) 2014 Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CafeReviewButton.h"

@interface PlaceCell : UITableViewCell

- (CafeReviewButton *)reviewButton;

- (void)loadItem:(Cafe *)item;

@end
