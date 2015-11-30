//
//  CheckReservationParser.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 10/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "CategoryFoodsParser.h"

#import "CJSONDeserializer.h"

#define CATEGORY_LOGO_URL @"http://www.coffeeapp.club/img/food_categories/"

#define FOOD_LOGO_URL @"http://www.coffeeapp.club/img/food_poza/"

@implementation CategoryFoodsParser

- (void)parseData:(NSData *)data
{
    _items = [NSMutableArray new];
    
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    
    NSError *deserializeError = nil;
    
//    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"Response category foods: %@", [responseString description]);
    
    NSDictionary *responseDict = [deserializer deserialize:data error:&deserializeError];

    NSString *response = [responseDict valueForKey:@"response"];
    
    if (response)
    {
        NSMutableArray* jsonArray = [responseDict objectForKey:@"result"];
        
        for (NSInteger i = 0; i < [jsonArray count]; i++) {
            
            
            
            NSDictionary* value = (NSDictionary*)[jsonArray objectAtIndex:i];
            
            CategoryModel *categoryObject = [[CategoryModel alloc] init];
            
            categoryObject.strCategoryId = [value objectForKey:@"category_id"];
            categoryObject.strCategoryName = [value objectForKey:@"category_name"];
            
            NSString *imglogo = @"";
            imglogo = [value objectForKey:@"category_logo"];
            
            if (imglogo && imglogo.length > 0) {
                
                categoryObject.imgCategoryLogo = [NSString stringWithFormat:@"%@%@", CATEGORY_LOGO_URL, imglogo];
                
            }
            
//            if(!categoryObject.imgCategoryLogo)
//                categoryObject.imgCategoryLogo  = IMG_LOGO_DEFAULT;
            
            categoryObject.arrayOfFoods = [NSMutableArray arrayWithCapacity:0];
            
            NSMutableArray *foodArray = [value objectForKey:@"foods"];
            for(NSInteger j = 0; j < [foodArray count]; j++ )
            {
                NSDictionary* foodValue = (NSDictionary*)[foodArray objectAtIndex:j];
                
                FoodModel *foodModel = [[FoodModel alloc] init];
                
                foodModel.strCategoryId = categoryObject.strCategoryId;
                foodModel.strFoodId = [foodValue objectForKey:@"food_id"];
                foodModel.strFoodName = [foodValue objectForKey:@"food_name"];
                foodModel.strquantity = [foodValue objectForKey:@"food_quantity"];
                foodModel.strPrice = [foodValue objectForKey:@"food_price"];
                foodModel.strNote = [foodValue objectForKey:@"food_note"];
                
                NSString *strImage = @"";
                strImage = [foodValue objectForKey:@"poza"];
                
                if (strImage && strImage.length > 0)
                {
                    foodModel.strImage = [NSString stringWithFormat:@"%@%@", FOOD_LOGO_URL, strImage];
                }
                
                foodModel.strMeasuringUnit = [foodValue objectForKey:@"unitate_masura"];
                
                [categoryObject.arrayOfFoods addObject:foodModel];
            }
            
            [_items addObject:categoryObject];
        }
   
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
