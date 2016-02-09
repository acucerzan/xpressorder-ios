//
// Table.m
// CafeApp
//
// Created by Lion on 11/27/14.
// Copyright (c) 2014 han. All rights reserved.
//

#import "Table.h"

@implementation Table


- (NSString *)description
{
	return [NSString stringWithFormat:@"TableId %@ PlaceId %@ phone %@  userAvailable %@ userState %@ isReserved %d isTable %d", self.table_id, self.place_id,
	        self.phone, self.user_available, self.state, self.isReserved, self.isTable];
}

- (TableState)tableState
{
	TableState localState = TableStateFree;

	if ([self.state isEqualToString:kBusyString])
		localState = TableStateBusy;
	else
		if (self.isReserved)
			localState = TableStateReserved;

	return localState;
}

@end