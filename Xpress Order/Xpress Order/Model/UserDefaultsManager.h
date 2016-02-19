//
// UserDefaultManager.h
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FoodOrder;
@class Cafe;

@interface UserDefaultsManager: NSObject

+ (void)setOrderedFoodArray:(NSArray <FoodOrder *> *)foodOrder forPlace:(Cafe *)place;
+ (NSArray <FoodOrder *> *)orderedFoodForPlace:(Cafe *)place;

@end