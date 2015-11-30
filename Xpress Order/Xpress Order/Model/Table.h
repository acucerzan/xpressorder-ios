//
//  Table.h
//  CafeApp
//
//  Created by Lion on 11/27/14.
//  Copyright (c) 2014 han. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TableAccess.h"

@interface Table : NSObject

@property (nonatomic, strong) NSString *table_id;
@property (nonatomic, strong) NSString *place_id;
@property (nonatomic, strong) NSString *user_phone_num;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_available;
@property (nonatomic, strong) NSString *user_state;

@property (nonatomic, strong) TableAccess *tableAccess;

@end
