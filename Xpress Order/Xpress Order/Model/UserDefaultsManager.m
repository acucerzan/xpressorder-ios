//
// UserDefaultManager.m
// Xpress Order
//
// Created by Constantin Saulenco on 18/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "UserDefaultsManager.h"

static UserDefaultsManager *sharedManager;

@interface UserDefaultsManager ()

@property (nonatomic, strong) NSUserDefaults *defaults;
+ (instancetype)sharedManager;
@end
@implementation UserDefaultsManager


+ (instancetype)sharedManager
{
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		sharedManager = [[UserDefaultsManager alloc] init];
	});
	return sharedManager;
}

- (instancetype)init
{
	if (sharedManager)
		return sharedManager;

	self = [super init];
	if (self)
		// additional initialisation
		self.defaults = [NSUserDefaults standardUserDefaults];

	return self;
}

+ (void)setOrderedFoodArray:(NSArray <FoodOrder *> *)foodOrder forPlace:(Cafe *)place
{
	UserDefaultsManager *manager = [UserDefaultsManager sharedManager];

	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:foodOrder];
	[manager.defaults setObject:data forKey:place.place_id];
	[manager.defaults synchronize];
}

+ (NSArray <FoodOrder *> *)orderedFoodForPlace:(Cafe *)place
{
	UserDefaultsManager *manager = [UserDefaultsManager sharedManager];

	NSData *data = [manager.defaults objectForKey:place.place_id];
	NSArray *orderedFoods = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	return orderedFoods;
}

@end