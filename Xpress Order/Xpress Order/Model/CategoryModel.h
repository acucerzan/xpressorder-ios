//
//  CategoryModel.h
//  CafeApp
//
//  Created by Lion on 12/18/14.
//  Copyright (c) 2014 han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, strong) NSString *strCategoryId;
@property (nonatomic, strong) NSString *strCategoryName;
@property (nonatomic, strong) NSString *imgCategoryLogo;
@property (nonatomic, strong) NSMutableArray *arrayOfFoods;

@end
