//
// Cafe.h
// CafeApp
//
// Created by Lion on 11/27/14.
// Copyright (c) 2014 han. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Table;
@interface Cafe: NSObject

@property (nonatomic, strong) NSString *place_id;
@property (nonatomic, strong) NSString *place_logo_image_name;
@property (nonatomic, strong) NSString *place_name;
@property (nonatomic, strong) NSNumber *place_review;

@property (nonatomic) BOOL haveHistory;
@property (nonatomic, strong) NSArray <Table *> *tables;

@end