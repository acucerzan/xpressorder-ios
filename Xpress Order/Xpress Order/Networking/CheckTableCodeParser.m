//
//  CheckReservationParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "CheckTableCodeParser.h"

#import "CJSONDeserializer.h"

#import "TableAccess.h"

@implementation CheckTableCodeParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response check pincode: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

    NSString *response = [responseDict valueForKey:@"response"];
    
    if (response)
    {
        if ([response isEqualToString:@"1"])
        {
            NSString *orderID = [responseDict valueForKey:@"order_id"];
            NSString *pinCode = [responseDict valueForKey:@"pin"];
            
            TableAccess *tableAccess = [TableAccess new];
            
            tableAccess.orderID = orderID;
            tableAccess.pinCode = pinCode;
            
            [_items addObject:tableAccess];
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
