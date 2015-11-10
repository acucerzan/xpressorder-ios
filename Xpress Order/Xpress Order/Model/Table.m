//
//  Table.m
//  CafeApp
//
//  Created by Lion on 11/27/14.
//  Copyright (c) 2014 han. All rights reserved.
//

#import "Table.h"

@implementation Table


-(NSString *) description
{
    return [NSString stringWithFormat:@"TableId %@ PlaceId %@ userPhoneNumber %@ UserName %@ userAvailable %@ userState %@", self.table_id, self.place_id,
            self.user_phone_num, self.user_name, self.user_available, self.user_state];
}
@end
