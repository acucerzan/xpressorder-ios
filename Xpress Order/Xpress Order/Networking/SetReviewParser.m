//
//  SetReviewParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "SetReviewParser.h"

#import "CJSONDeserializer.h"

@implementation SetReviewParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response set review: %@", [responseString description]);
    
//    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];
//    
//    NSString *response = [responseDict valueForKey:@"response"];
//    
//    NSString *message = [[NSString alloc] init];
//    
//    if([response isEqualToString:@"1"]) {
//        
//    } else if([response isEqualToString:@"0"]) {
//        message = NSLocalizedString(@"Connection Failed!", nil);
//    }
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
