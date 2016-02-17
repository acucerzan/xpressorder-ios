//
// CheckReservationParser.m
// Xpress Order
//
// Created by Adrian Cucerzan on 10/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "MyFoodsParser.h"
#import "FoodOrder.h"

#import "CJSONDeserializer.h"

#define CATEGORY_LOGO_URL @"http://www.coffeeapp.club/img/food_categories/"

#define FOOD_LOGO_URL @"http://www.coffeeapp.club/img/food_poza/"

@implementation MyFoodsParser

- (void)parseData:(NSData *)data
{
	_items = [NSMutableArray new];

	CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];

	NSError *deserializeError = nil;

	NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"Response my foods: %@", [responseString description]);

	NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

	NSString *response = [responseDict valueForKey:@"response"];

	if ([response isEqualToString:@"1"]) {
		NSMutableArray *foodArray = [responseDict objectForKey:@"food_list"];
		for (NSInteger j = 0; j < [foodArray count]; j++) {
			NSDictionary *foodValue = (NSDictionary *) [foodArray objectAtIndex:j];

			FoodOrder *foodModel = [[FoodOrder alloc] init];

			foodModel.foodId = [foodValue objectForKey:kFoodId];
			foodModel.foodName = [foodValue objectForKey:kFoodName];
			foodModel.foodQuantity = [foodValue objectForKey:kFoodQuantity];
			foodModel.foodPrice = [foodValue objectForKey:kFoodPrice];
			foodModel.foodOrdered = [foodValue objectForKey:kFoodOrdered];
			foodModel.foodOrderedQuantity = [foodValue objectForKey:kFoodOrderedQuantity];

			NSString *strImage = @"";
			strImage = [foodValue objectForKey:kFoodImageName];

			if (strImage && strImage.length > 0)
				foodModel.foodImageName = [NSString stringWithFormat:@"%@%@", FOOD_LOGO_URL, strImage];

			foodModel.foodMeasuringUnit = [foodValue objectForKey:kFoodMeasuringUnitt];

			[_items addObject:foodModel];
		}
	}
	else
		_error = [NSError new];
}

- (NSError *)error
{
	return _error;
}

- (NSArray *)itemsArray
{
	return [NSArray arrayWithArray:_items];
}

@end