//
//  EventsParser.h
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/08/14.
//

#import <Foundation/Foundation.h>

#import "LParserInterface.h"

@interface PlaceListParser : NSObject <LParserInterface>
{
    NSMutableString *_mElementValue;
    
    NSError *_error;
    NSMutableArray *_items;
}


@end
