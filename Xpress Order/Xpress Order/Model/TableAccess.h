//
// TableAccess.h
// Xpress Order
//
// Created by Adrian Cucerzan on 30/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableAccess: NSObject

@property (nonatomic, strong) NSString *orderID, *pinCode, *placeID, *tableNumber;
@property (nonatomic, strong) NSString *customerEmail, *customerName, *customerPhone;
@end