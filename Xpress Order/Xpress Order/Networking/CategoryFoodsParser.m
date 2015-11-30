//
//  CheckReservationParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "CategoryFoodsParser.h"

#import "CJSONDeserializer.h"

#import "ReservationCheck.h"

#import "FoodModel.h"
#import "CategoryModel.h"

@implementation CategoryFoodsParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response call waitress: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

    NSString *response = [responseDict valueForKey:@"response"];
    
    if (response)
    {
        NSMutableArray* jsonArray = [responseDict objectForKey:@"result"];
        
//        if(arrayCategory)
//            [arrayCategory removeAllObjects];
//        
//        if(arrayFood)
//            [arrayFood removeAllObjects];
        
        for (NSInteger i = 0; i < [jsonArray count]; i++) {
            
            
            
            NSDictionary* value = (NSDictionary*)[jsonArray objectAtIndex:i];
            
            CategoryModel *CategoryObject = [[CategoryModel alloc] init];
            
            CategoryObject.strCategoryId = [value objectForKey:@"category_id"];
            CategoryObject.strCategoryName = [value objectForKey:@"category_name"];
            
            NSString *imglogo = @"";
            imglogo = [value objectForKey:@"category_logo"];
            
            if (imglogo && ![imglogo isEqualToString:@""]) {
                
//                CategoryObject.imgCategoryLogo = [Utility getCachedImageFromPath:PATH_IMAGES_CATEGORY withName:[Utility thumbForFilename:imglogo]];
                
            }
            
//            if(!CategoryObject.imgCategoryLogo ) CategoryObject.imgCategoryLogo  = IMG_LOGO_DEFAULT;
            
            
            NSMutableArray *foodArray = [value objectForKey:@"foods"];
            for(NSInteger j = 0; j < [foodArray count]; j++ )
            {
                NSDictionary* foodValue = (NSDictionary*)[foodArray objectAtIndex:j];
                
                FoodModel *foodModel = [[FoodModel alloc] init];
                
                foodModel.strCategoryId = CategoryObject.strCategoryId;
                foodModel.strFoodId = [foodValue objectForKey:@"food_id"];
                foodModel.strFoodName = [foodValue objectForKey:@"food_name"];
                foodModel.strquantity = [foodValue objectForKey:@"food_quantity"];
                foodModel.strPrice = [foodValue objectForKey:@"food_price"];
                foodModel.strNote = [foodValue objectForKey:@"food_note"];
                
//                [arrayFood addObject:foodModel];
            }
            
//            [arrayCategory addObject:CategoryObject];
        }
        
        
//        if(arrayTemp)
//            [arrayTemp removeAllObjects];
        
//        for (int i=0; i<arrayFood.count; i++ ) {
//            
//            NSString *strName = [[arrayFood objectAtIndex:i] strCategoryId];
//            if ( [[[arrayCategory objectAtIndex:selIndex] strCategoryId] isEqualToString:strName] ) {
//                FoodModel *foodModel = [[FoodModel alloc] init];
//                
//                foodModel.strCategoryId = [[arrayFood objectAtIndex:i] strCategoryId];
//                foodModel.strFoodId = [[arrayFood objectAtIndex:i] strFoodId];
//                foodModel.strFoodName = [[arrayFood objectAtIndex:i] strFoodName];
//                foodModel.strquantity = [[arrayFood objectAtIndex:i] strquantity];
//                foodModel.strPrice = [[arrayFood objectAtIndex:i] strPrice];
//                foodModel.strNote = [[arrayFood objectAtIndex:i] strNote];
//                
//                [arrayTemp addObject:foodModel];
//            }
//        }
    }
}

- (NSError *)error
{
    return _error;
}

- (NSArray *)itemsArray
{
    return [NSArray arrayWithArray:_items];
}

@end
