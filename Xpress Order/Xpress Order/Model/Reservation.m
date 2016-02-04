//
//  Reservation.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 03/02/16.
//  Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "Reservation.h"

@implementation Reservation

-(NSString *)description
{
    return [NSString stringWithFormat:@"Reservation \n place: %@ \n clienName %@ \n clientEmail %@ \n clientPhone: %@ \n clientDate %@ \n nrPersons %@ \n clientPbservation %@", self.place, self.clientName, self.clientEmail, self.clientPhone, self.clientDate, self.personCount, self.clientObservation ];
}
@end
