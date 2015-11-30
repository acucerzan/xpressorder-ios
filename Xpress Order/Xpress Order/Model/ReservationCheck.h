//
//  ReservationCheck.h
//  Xpress Order
//
//  Created by Adrian Cucerzan on 30/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationCheck : NSObject

@property (nonatomic) BOOL isReserved;
@property (nonatomic, strong) NSString *comingDate, *arrivalTime;

@end
