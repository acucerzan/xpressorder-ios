//
// CheckReservationParser.m
// Xpress Order
//
// Created by Adrian Cucerzan on 10/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "AddToOrderParser.h"

#import "CJSONDeserializer.h"

#import "TableAccess.h"

@implementation AddToOrderParser

- (void)parseData:(NSData *)data
{
	_items = [NSMutableArray new];

	CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];

	NSError *deserializeError = nil;

	NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	NSLog(@"Response Add to Order: %@", [responseString description]);

	NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

	NSString *response = [responseDict valueForKey:@"response"];

	if ([response isEqualToString:@"1"])
		_items = [NSMutableArray new];
	else if ([response isEqualToString:@"0"])
		_error = [NSError errorWithDomain:@"Error" code:200 userInfo:@{ @"message": NSLocalizedString(@"Connection Failed!", nil) }];
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