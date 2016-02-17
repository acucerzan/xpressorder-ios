//
// FoodOrder.m
// Xpress Order
//
// Created by Constantin Saulenco on 17/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "FoodOrder.h"

@implementation FoodOrder

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.foodName forKey:kFoodName];
	[aCoder encodeObject:self.foodId forKey:kFoodId];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [[FoodOrder alloc] init];
	if (self) {
		self.foodId = [aDecoder decodeObjectForKey:kFoodId];
		self.foodName = [aDecoder decodeObjectForKey:kFoodName];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"foodID :%@ \n foodName :%@ \n foodImag: %@ \n foodPrice:%@ \n foodOrderedQuantity:%@ ", self.foodId, self.foodName, self.foodImageName, self.foodPrice, self.foodOrderedQuantity];
}

@end