//
//  CheckReservationParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "CheckReservationParser.h"

#import "CJSONDeserializer.h"

#import "ReservationCheck.h"

@implementation CheckReservationParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response check reservation: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

    NSString *response = [responseDict valueForKey:@"response"];
    
    if (response)
    {
        if ([response isEqualToString:@"1"])
        {
            NSString *commingDate = [responseDict valueForKey:@"coming_date"];
            NSString *arrivalTime = [responseDict valueForKey:@"arriving_time"];
            
            ReservationCheck *check = [ReservationCheck new];
            
            check.isReserved = [response isEqualToString:@"1"];
            
            check.comingDate = commingDate;
            check.arrivalTime = arrivalTime;
            
            [_items addObject:check];
        }
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
