//
// Reservation.h
// Xpress Order
//
// Created by Constantin Saulenco on 03/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reservation: NSObject
@property (nonatomic, strong) Cafe *place;
@property (nonatomic, strong) NSString *clientName;
@property (nonatomic, strong) NSString *clientEmail;
@property (nonatomic, strong) NSString *clientPhone;
@property (nonatomic, strong) NSDate *clientDate;
@property (nonatomic, strong) NSNumber *personCount;
@property (nonatomic, strong) NSString *androidID;
@property (nonatomic, strong) NSString *clientObservation;

@end