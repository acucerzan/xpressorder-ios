//
// FoodOrder.h
// Xpress Order
//
// Created by Constantin Saulenco on 17/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFoodId              @"id"
#define kFoodName            @"name"
#define kFoodImageName       @"poza"
#define kFoodQuantity        @"quantity"
#define kFoodPrice           @"price"
#define kFoodOrderedQuantity @"cantitate"
#define kFoodOrdered         @"ordered"
#define kFoodMeasuringUnitt  @"unitate_masura"

@interface FoodOrder: NSObject <NSCoding>

@property (nonatomic, strong) NSString *foodId;
@property (nonatomic, strong) NSString *foodName;
@property (nonatomic, strong) NSString *foodImageName;
@property (nonatomic, strong) NSString *foodQuantity;
@property (nonatomic, strong) NSString *foodPrice;
@property (nonatomic, strong) NSString *foodOrderedQuantity;
@property (nonatomic, strong) NSString *foodOrdered;
@property (nonatomic, strong) NSString *foodMeasuringUnit;

@end