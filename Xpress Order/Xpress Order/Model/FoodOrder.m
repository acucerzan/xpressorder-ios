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
	[aCoder encodeObject:self.foodImageName forKey:kFoodImageName];
	[aCoder encodeObject:self.foodQuantity forKey:kFoodQuantity];
	[aCoder encodeObject:self.foodPrice forKey:kFoodPrice];
	[aCoder encodeObject:self.foodOrderedQuantity forKey:kFoodOrderedQuantity];
	[aCoder encodeObject:self.foodOrdered forKey:kFoodOrdered];
	[aCoder encodeObject:self.foodMeasuringUnit forKey:kFoodMeasuringUnitt];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [[FoodOrder alloc] init];
	if (self) {
		self.foodId = [aDecoder decodeObjectForKey:kFoodId];
		self.foodName = [aDecoder decodeObjectForKey:kFoodName];
		self.foodImageName = [aDecoder decodeObjectForKey:kFoodImageName];
		self.foodQuantity = [aDecoder decodeObjectForKey:kFoodQuantity];
		self.foodPrice = [aDecoder decodeObjectForKey:kFoodPrice];
		self.foodOrderedQuantity = [aDecoder decodeObjectForKey:kFoodOrderedQuantity];
		self.foodOrdered = [aDecoder decodeObjectForKey:kFoodOrdered];
		self.foodMeasuringUnit = [aDecoder decodeObjectForKey:kFoodMeasuringUnitt];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"foodID :%@ \n foodName :%@ \n foodImag: %@ \n foodPrice:%@ \n foodOrderedQuantity:%@ ", self.foodId, self.foodName, self.foodImageName, self.foodPrice, self.foodOrderedQuantity];
}

@end