//
// FoodModel.h
// CafeApp
//
// Created by Lion on 1/7/15.
// Copyright (c) 2015 han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel: NSObject

@property (nonatomic, strong) NSString *strCategoryId;
@property (nonatomic, strong) NSString *strFoodId;
@property (nonatomic, strong) NSString *strFoodName;
@property (nonatomic, strong) NSString *strquantity;
@property (nonatomic, strong) NSString *strPrice;
@property (nonatomic, strong) NSString *strNote;
@property (nonatomic, strong) NSString *strImage;
@property (nonatomic, strong) NSString *strMeasuringUnit;
@property (nonatomic, strong) NSString *strRecipie;

@end