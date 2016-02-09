//
// Table.h
// CafeApp
//
// Created by Lion on 11/27/14.
// Copyright (c) 2014 han. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TableAccess.h"

typedef NS_ENUM (NSInteger, TableState) {
	TableStateFree = 0,
	TableStateBusy,
	TableStateReserved
};

#define kBusyString @"busy"
#define kNoneString @"none"

@interface Table: NSObject

@property (nonatomic, strong) NSString *table_id;
@property (nonatomic, strong) NSString *place_id;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *user_available;
@property (nonatomic, strong) NSString *state;
@property (nonatomic) BOOL isTable;
@property (nonatomic) BOOL isReserved;

@property (nonatomic) TableState tableState;
@property (nonatomic, strong) TableAccess *tableAccess;

@end