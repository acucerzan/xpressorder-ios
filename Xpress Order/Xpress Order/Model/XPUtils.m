//
//  XPUtils.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 14/01/16.
//  Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "XPUtils.h"

@implementation XPUtils

#pragma mark --- Image methods

+ (UIImage *)imageWithColor:(__weak UIColor *)color andFrame:(CGRect)frame
{
    @autoreleasepool {
        CGRect rect = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
        __weak UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        context = nil;
        
        UIGraphicsEndImageContext();
        
        return image;
    }
}

+ (UIImage *)imageByCombiningImage:(UIImage *)firstImage withImage:(UIImage *)secondImage
{
    UIImage *image = nil;
    
    CGSize newImageSize = CGSizeMake(MAX(firstImage.size.width, secondImage.size.width), MAX(firstImage.size.height, secondImage.size.height));
    // if (UIGraphicsBeginImageContextWithOptions != 0) // no validation is neede we are always above ios8.0
    UIGraphicsBeginImageContextWithOptions(newImageSize, NO, [[UIScreen mainScreen] scale]);
    // else
    // UIGraphicsBeginImageContext(newImageSize);
    [firstImage drawAtPoint:CGPointMake(roundf((newImageSize.width - firstImage.size.width) / 2),
                                        roundf((newImageSize.height - firstImage.size.height) / 2))];
    [secondImage drawAtPoint:CGPointMake(roundf((newImageSize.width - secondImage.size.width) / 2),
                                         roundf((newImageSize.height - secondImage.size.height) / 2))];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
