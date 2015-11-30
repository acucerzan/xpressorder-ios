//
//  TablesParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TablesParser.h"

#import "CJSONDeserializer.h"

#import "Table.h"

@implementation TablesParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    NSLog(@"Response: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];
    
    NSString *response = [responseDict valueForKey:@"response"];
    
    NSString *message = [[NSString alloc] init];
    
    if([response isEqualToString:@"1"]) {
        NSMutableArray* jsonArray = [responseDict objectForKey:@"table_list"];
        
        for (NSInteger i = 0; i < [jsonArray count]; i++) {
            
            NSDictionary* value = (NSDictionary*)[jsonArray objectAtIndex:i];
            
            Table *tableObject = [[Table alloc] init];
            
            tableObject.table_id = [value objectForKey:@"table_no"];
            tableObject.place_id = [value objectForKey:@"place_id"];
            tableObject.user_phone_num = [value objectForKey:@"phone"];
            tableObject.user_name = [value objectForKey:@"username"];
            tableObject.user_available = [value objectForKey:@"user_available"];
            tableObject.user_state = [value objectForKey:@"state"];
            
            NSLog(@"Table state: %@", tableObject.user_state);
            
            [_items addObject:tableObject];
            
        }
        
    } else if([response isEqualToString:@"0"]) {
        message = NSLocalizedString(@"Connection Failed!", nil);
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
