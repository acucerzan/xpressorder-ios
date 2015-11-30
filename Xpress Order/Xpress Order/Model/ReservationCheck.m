//
//  ReservationCheck.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 30/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "ReservationCheck.h"

@implementation ReservationCheck

- (NSString *)description
{
    return [NSString stringWithFormat:@"Rezervat în data de %@ la ora %@", self.comingDate, self.arrivalTime];
}

@end
