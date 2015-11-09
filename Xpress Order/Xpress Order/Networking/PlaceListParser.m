//
//  RequestParser.m
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/08/14.
//

#import "PlaceListParser.h"

#import "CJSONDeserializer.h"

#pragma mark Macro Definition KEYS
#pragma mark -


@implementation PlaceListParser

#pragma mark Parsers 
#pragma mark -


- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];

    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSLog(@"Response: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];
    
    NSString *response = [responseDict valueForKey:@"response"];
    
    NSString *message = [[NSString alloc] init];
    
    if([response isEqualToString:@"1"]) {
            
            NSMutableArray* jsonArray = [responseDict objectForKey:@"place_list"];
            
            for (NSInteger i = 0; i < [jsonArray count]; i++) {
                NSString *imglogo = @"";
                NSDictionary* value = (NSDictionary*)[jsonArray objectAtIndex:i];
                
                Cafe *cafeObj = [[Cafe alloc] init];
                cafeObj.place_id = [value objectForKey:@"id"];
                imglogo = [value objectForKey:@"logo"];
                
                if (imglogo && ![imglogo isEqualToString:@""]) {
                    
                    if ([imglogo hasSuffix:@".png"])
                        imglogo = [imglogo substringToIndex:imglogo.length-@".png".length];
                    
                    cafeObj.place_logo_image_name = imglogo;
                    
                }
                
                if (!cafeObj.place_logo_image_name)
                    cafeObj.place_logo_image_name = @"place_list_logo";
                
                cafeObj.place_name = [value objectForKey:@"name"];
                float review = [[value objectForKey:@"place_review"] floatValue];
                
                cafeObj.place_review = [NSNumber numberWithFloat:review];
                
                [_items addObject:cafeObj];
                
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
