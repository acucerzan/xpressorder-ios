//
// CheckReservationParser.m
// Xpress Order
//
// Created by Adrian Cucerzan on 10/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "CompareTableCodeParser.h"
#import "CJSONDeserializer.h"
#import "TableAccess.h"


#define kTableNumber   @"table_no"
#define kPlaceId       @"place_id"
#define kPinCode       @"pin"
#define kOrderId       @"order_id"
#define kCustomerEmail @"customer_email"
#define kCustomerName  @"customer_name"
#define kCustomerPhone @"customer_phone"

@implementation CompareTableCodeParser

- (void)parseData:(NSData *)data
{
	_items = [NSMutableArray new];

	CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];

	NSError *deserializeError = nil;

	NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	NSLog(@"Response compare pincode: %@", [responseString description]);

	NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

	NSString *response = [responseDict valueForKey:@"response"];

	if (response) {
		if ([response isEqualToString:@"1"]) {
			NSString *orderID = [responseDict valueForKey:kOrderId];
			NSString *placeID = [responseDict valueForKey:kPlaceId];
			NSString *pinCode = [responseDict valueForKey:kPinCode];
			NSString *tableNumer = [responseDict valueForKey:kTableNumber];

			NSString *email = [responseDict valueForKey:kCustomerEmail];
			NSString *name = [responseDict valueForKey:kCustomerName];
			NSString *phone = [responseDict valueForKey:kCustomerPhone];

			TableAccess *tableAccess = [TableAccess new];

			tableAccess.orderID = orderID;
			tableAccess.pinCode = pinCode;
			tableAccess.placeID = placeID;
			tableAccess.tableNumber = tableNumer;

			tableAccess.customerEmail = email;
			tableAccess.customerName = name;
			tableAccess.customerPhone = phone;

			[_items addObject:tableAccess];
		}
	}
	else
		_error = [NSError errorWithDomain:@"Error" code:1 userInfo:nil];
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