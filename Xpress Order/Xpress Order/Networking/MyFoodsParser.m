//
//  CheckReservationParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "MyFoodsParser.h"

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
    
    if (response)
    {
//        NSMutableArray* jsonArray = [responseDict objectForKey:@"result"];
        // TODO need to check array of food ids that are on my order.
   
    }
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
