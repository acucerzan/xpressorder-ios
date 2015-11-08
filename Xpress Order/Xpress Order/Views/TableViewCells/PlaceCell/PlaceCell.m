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


//#define kLabelsContainer 407

@interface PlaceCell ()

@end

@implementation PlaceCell

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

- (HCSStarRatingView *)visitsLabel
{
    return (HCSStarRatingView *)[self viewWithTag:kRatingView];
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
    
//    UIView *containerView = [self labelsContainerView];
//    containerView.layer.cornerRadius = 2;
//    
//    containerView.layer.borderWidth = 1.0f;

    
    
    UIButton *reviewBtn = [self reviewButton];
    [reviewBtn setTitle:@"REVIEW" forState:UIControlStateNormal];

    
    NSLog(@"Place review: %@", item.place_review);
}

@end
