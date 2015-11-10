//
//  Cafe.m
//  CafeApp
//
//  Created by Lion on 11/27/14.
//  Copyright (c) 2014 han. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe

- (NSString *)description
{
    return [NSString stringWithFormat:@"Place named %@ with review %@, logo url\n %@ and id: %@", self.place_name, self.place_review, self.place_logo_image_name, self.place_id];
}

@end
