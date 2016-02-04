//
// CheckReservationParser.m
// Xpress Order
//
// Created by Adrian Cucerzan on 10/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TakeTableParser.h"

#import "CJSONDeserializer.h"

#define CATEGORY_LOGO_URL @"http://www.coffeeapp.club/img/food_categories/"

#define FOOD_LOGO_URL @"http://www.coffeeapp.club/img/food_poza/"


#define kResponse @"response"
#define kPin      @"pin"

@implementation TakeTableParser

- (void)parseData:(NSData *)data
{
	_items = [NSMutableArray new];

	CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];

	NSError *deserializeError = nil;

	NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"Response take table: %@", [responseString description]);

	NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

	NSString *response = [responseDict valueForKey:kResponse];

	if (response)
		[_items addObject:@"1"];


	NSString *pin = [responseDict valueForKey:kPin];
	if (pin)
		[_items addObject:pin];
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