//
//  FoodModel.m
//  CafeApp
//
//  Created by Lion on 1/7/15.
//  Copyright (c) 2015 han. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"    Food: %@ id: %@ price %@ quantity: %@ %@, note: %@ image: %@", self.strFoodName, self.strFoodId, self.strPrice, self.strquantity, self.strMeasuringUnit, self.strNote, self.strImage];
}

@end
