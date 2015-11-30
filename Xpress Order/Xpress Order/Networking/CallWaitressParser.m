//
//  CheckReservationParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "CallWaitressParser.h"

#import "CJSONDeserializer.h"

#import "ReservationCheck.h"

@implementation CallWaitressParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response call waitress: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

    NSString *response = [responseDict valueForKey:@"response"];
    
    if (response)
    {
        [_items addObject:response];
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
