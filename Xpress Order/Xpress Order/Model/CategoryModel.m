//
// CategoryModel.m
// CafeApp
//
// Created by Lion on 12/18/14.
// Copyright (c) 2014 han. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (NSString *)description
{
	return [NSString stringWithFormat:@"Categoria: %@ id: %@ logo: %@ \n    %@", self.strCategoryName, self.strCategoryId, self.imgCategoryLogo, self.arrayOfFoods];
}

- (instancetype)initWithModel:(CategoryModel *)categoryModel andFoodArray:(NSArray *)foodArray
{
	self = [super init];
	if (self) {
		self.strCategoryId = categoryModel.strCategoryId;
		self.strCategoryName = categoryModel.strCategoryName;
		self.imgCategoryLogo = categoryModel.imgCategoryLogo;
		self.arrayOfFoods = [NSMutableArray arrayWithArray:foodArray];
	}

	return self;
}

@end