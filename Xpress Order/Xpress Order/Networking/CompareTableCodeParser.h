//
//  CheckReservationParser.h
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LParserInterface.h"

@interface CompareTableCodeParser : NSObject <LParserInterface>
{
    NSMutableString *_mElementValue;
    
    NSError *_error;
    NSMutableArray *_items;
}

@end
