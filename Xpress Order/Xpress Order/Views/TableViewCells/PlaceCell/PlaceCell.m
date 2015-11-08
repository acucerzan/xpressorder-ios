//
//  LeftMenuCell.m
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/09/14.
//  Copyright (c) 2014 Cucerzan. All rights reserved.
//

#import "PlaceCell.h"

#import "UIImageView+AFNetworking.h"

#define kMerchantImageView 401
#define kMerchantNameLabel 402
#define kLikeButton 403
#define kDistanceButton 404
#define kVisitsLabel 405
#define kPointsLabel 406
#define kLabelsContainer 407

@interface PlaceCell ()

@end

@implementation PlaceCell

- (UIImageView *)merchantImageView
{
    return (UIImageView *)[self viewWithTag:kMerchantImageView];
}

- (UILabel *)merchantNameLabel
{
    return (UILabel *)[self viewWithTag:kMerchantNameLabel];
}

- (UIButton *)likeButton
{
    return (UIButton *)[self viewWithTag:kLikeButton];
}

//- (MVDistanceButton *)distanceButton
//{
//    return (MVDistanceButton *)[self viewWithTag:kDistanceButton];
//}

- (UILabel *)visitsLabel
{
    return (UILabel *)[self viewWithTag:kVisitsLabel];
}

- (UILabel *)pointsLabel
{
    return (UILabel *)[self viewWithTag:kPointsLabel];
}

- (UIImageView *)imageView
{
    return [self merchantImageView];
}

- (UILabel *)titleLabel
{
    return [self merchantNameLabel];
}

- (UIView *)labelsContainerView
{
    return [self viewWithTag:kLabelsContainer];
}

- (void)loadMerchantImage:(UIImage *)image
{
    UIImageView *merchantImgView = [self merchantImageView];
    
    [merchantImgView setContentMode:UIViewContentModeScaleAspectFill];
    [merchantImgView setClipsToBounds:YES];
    merchantImgView.layer.masksToBounds = YES;
    [merchantImgView setImage:image];
}

//- (void)loadItem
//{
//    UIImageView *merchantImgView = [self merchantImageView];
//    
//    [merchantImgView setContentMode:UIViewContentModeCenter];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:merchant.photo.url]];
//    [merchantImgView setImageWithURLRequest:request placeholderImage:Image(@"ic_place_holder") success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        [self loadMerchantImage:image];
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        NSLog(@"Place Failed dowloading merchant image");
//    }];
//    
//    merchantImgView.layer.cornerRadius = 1;
//    
//    UIView *containerView = [self labelsContainerView];
//    containerView.layer.cornerRadius = 2;
//    
//    containerView.layer.borderWidth = 1.0f;
//
//    UIButton *likeBtn = [self likeButton];
//    likeBtn.selected = [merchant.isFavorite boolValue];
//    
//    UILabel *merchantNameLbl = [self merchantNameLabel];
//    
//    [merchantNameLbl setText:merchant.placeName];
//    
//    UILabel *visitsLbl = [self visitsLabel];
//    
//    [visitsLbl setText:[NSString stringWithFormat:@"%d %@", [merchant.visits intValue], lang(@"visits_text")]];
//
//    UILabel *pointsLbl = [self pointsLabel];
//	if (merchant.rewardInfo && merchant.rewardInfo.points)
//		[pointsLbl setText:fmt(@"%d %@", [merchant.rewardInfo.points intValue], _(@"points_text"))];
//
//    MVDistanceButton *distanceBtn = [self distanceButton];
//    
//	[distanceBtn setDistance:merchant.distance];
//    
//    
//    NSString *distanceString = [distanceBtn distanceInKmToCurrentLocation];
//    [distanceBtn setTitle:distanceString forState:UIControlStateNormal];
//    
//}

@end
