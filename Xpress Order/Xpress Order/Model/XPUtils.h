//
// XPUtils.h
// Xpress Order
//
// Created by Constantin Saulenco on 14/01/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPUtils: NSObject

#pragma mark --- Image methods

+ (UIImage *)imageWithColor:(UIColor *)color andFrame:(CGRect)frame;
+ (UIImage *)imageByCombiningImage:(UIImage *)firstImage withImage:(UIImage *)secondImage;

@end