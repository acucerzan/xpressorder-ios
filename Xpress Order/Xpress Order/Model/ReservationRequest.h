//
//  ReservationRequest.h
//  Xpress Order
//
//  Created by Adrian Cucerzan on 23/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationRequest : NSObject

@property (nonatomic, strong) NSString *placeID, *tableNumber, *name, *email, *nrOfPersons;


@end
