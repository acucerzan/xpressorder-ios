//
// LeftMenuCell.m
// XpressOrder
//
// Created by Adrian Cucerzan on 22/09/14.
// Copyright (c) 2014 Cucerzan. All rights reserved.
//

#import "PlaceCell.h"

#import "UIImageView+AFNetworking.h"

#import "HCSStarRatingView.h"

#define kImageView        101
#define kNameLabel        102
#define kReviewButton     104
#define kRatingView       103
#define kViewSeparatorTag 105

// #define kLabelsContainer 407

@interface PlaceCell ()

@end

@implementation PlaceCell

- (UIView *)viewSeparator
{
	return [self viewWithTag:kViewSeparatorTag];
}

- (UIImageView *)imageView
{
	return [self placeImageView];
}

- (UIImageView *)placeImageView
{
	return (UIImageView *) [self viewWithTag:kImageView];
}

- (UILabel *)placeNameLabel
{
	return (UILabel *) [self viewWithTag:kNameLabel];
}

- (CafeReviewButton *)reviewButton
{
	return (CafeReviewButton *) [self viewWithTag:kReviewButton];
}

- (HCSStarRatingView *)ratingsView
{
	return (HCSStarRatingView *) [self viewWithTag:kRatingView];
}

- (void)ratingViewChanged
{
	NSLog(@"Value changed");

	CafeReviewButton *reviewButton = [self reviewButton];

	if (reviewButton.weakPlace) {
		HCSStarRatingView *starView = [self ratingsView];

		[reviewButton.weakPlace setPlace_review:[NSNumber numberWithFloat:starView.value]];
	}
}

- (void)loadPlaceImage:(UIImage *)image
{
	UIImageView *merchantImgView = [self placeImageView];

	[merchantImgView setContentMode:UIViewContentModeScaleToFill];
	[merchantImgView setClipsToBounds:YES];
	merchantImgView.layer.masksToBounds = YES;
	[merchantImgView setImage:image];
}

- (void)loadItem:(Cafe *)item
{
	UILabel *placeNameLabel = [self placeNameLabel];
	[placeNameLabel setText:item.place_name];
	[placeNameLabel setFont:MainFontBold(24)];
	[placeNameLabel setTextColor:[UIColor whiteColor]];
	[placeNameLabel setBackgroundColor:ClearColor];


	UIImageView *placeImgView = [self placeImageView];
	NSString *imageName = item.place_logo_image_name;

	[self setButton:self.buttonHistory withText:@"Istoric"];
	[self setButton:self.buttonReservTable withText:@"Rezervare"];
    [self setButton:self.buttonMenu withText:@"Meniu"];

	[self.viewButtonsBase setBackgroundColor:ClearColor];
	[self.viewSeparator setBackgroundColor:[UIColor whiteColor]];

// http://www.coffeeapp.club/img/places/
	if (imageName && imageName.length > 0) {
		[placeImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.coffeeapp.club/img/places/%@", imageName]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
		  [self loadPlaceImage:image];
		} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
		  [self loadPlaceImage:[UIImage imageNamed:@"place_list_logo"]];
		}];
	}
	else
		[self loadPlaceImage:[UIImage imageNamed:@"place_list_logo"]];


	HCSStarRatingView *starView = [self ratingsView];
	starView.minimumValue = 0;
	starView.maximumValue = 5;
	starView.allowsHalfStars = YES;
	starView.spacing = 1;
	starView.tintColor = XP_PURPLE;

	starView.value = [item.place_review floatValue];

// [starView addTarget:self action:@selector(ratingViewChanged) forControlEvents:UIControlEventValueChanged];

	starView.userInteractionEnabled = NO;

	NSLog(@"Place review: %@", item.place_review);
}

- (void)setButton:(UIButton *)button withText:(NSString *)text
{
	[button setBackgroundColor:[UIColor clearColor]];
	[button setExclusiveTouch:YES];
	button.layer.borderWidth = 1;
	button.layer.borderColor = [UIColor whiteColor].CGColor;
	[button.layer setCornerRadius:3];
	[button setTitle:text forState:0];
	[button setClipsToBounds:YES];

	UIImage *image = [XPUtils imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:.4] andFrame:button.frame];
	[button setBackgroundImage:image forState:1];
}

@end