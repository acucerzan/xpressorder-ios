//
//  LeftMenuCell.m
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/09/14.
//  Copyright (c) 2014 Cucerzan. All rights reserved.
//

#import "PlaceCell.h"

#import "UIImageView+AFNetworking.h"

#import "HCSStarRatingView.h"

#define kImageView 101
#define kNameLabel 102
#define kReviewButton 104
#define kRatingView 103
#define kViewSeparatorTag 105

//#define kLabelsContainer 407

@interface PlaceCell ()

@end

@implementation PlaceCell

-(UIView *) viewSeparator
{
    return [self viewWithTag:kViewSeparatorTag];
}

- (UIImageView *)imageView
{
    return [self placeImageView];
}

- (UIImageView *)placeImageView
{
    return (UIImageView *)[self viewWithTag:kImageView];
}

- (UILabel *)placeNameLabel
{
    return (UILabel *)[self viewWithTag:kNameLabel];
}

- (CafeReviewButton *)reviewButton
{
    return (CafeReviewButton *)[self viewWithTag:kReviewButton];
}

- (HCSStarRatingView *)ratingsView
{
    return (HCSStarRatingView *)[self viewWithTag:kRatingView];
}

- (void)ratingViewChanged
{
    NSLog(@"Value changed");
    
    CafeReviewButton *reviewButton = [self reviewButton];
    
    if (reviewButton.weakPlace)
    {
        HCSStarRatingView *starView = [self ratingsView];
        
        [reviewButton.weakPlace setPlace_review:[NSNumber numberWithFloat:starView.value]];
    }
}

- (void)loadPlaceImage:(UIImage *)image
{
    UIImageView *merchantImgView = [self placeImageView];
    
    [merchantImgView setContentMode:UIViewContentModeScaleAspectFill];
    [merchantImgView setClipsToBounds:YES];
    merchantImgView.layer.masksToBounds = YES;
    [merchantImgView setImage:image];
}

- (void)loadItem:(Cafe *)item
{
    UIImageView *placeImgView = [self placeImageView];
    
    NSString *imageName = item.place_logo_image_name;
    
    if (imageName && imageName.length > 0) {
        [placeImgView setImage:[UIImage imageNamed:imageName]];
    }
    else
    {
        [placeImgView setImage:[UIImage imageNamed:@"place_list_logo"]];
    }
    
    
    UILabel *placeNameLabel = [self placeNameLabel];
    [placeNameLabel setText:item.place_name];
    
    
    UIButton *reviewBtn = [self reviewButton];
    [reviewBtn setTitle:@"Trimite recenzie" forState:UIControlStateNormal];

    HCSStarRatingView *starView = [self ratingsView];
    starView.minimumValue = 0;
    starView.maximumValue = 5;
    starView.allowsHalfStars = YES;
    starView.tintColor = XP_PURPLE;
    
    starView.value = [item.place_review floatValue];
    
    [starView addTarget:self action:@selector(ratingViewChanged) forControlEvents:UIControlEventValueChanged];
    
    starView.userInteractionEnabled = YES;
    
    NSLog(@"Place review: %@", item.place_review);
}

@end
