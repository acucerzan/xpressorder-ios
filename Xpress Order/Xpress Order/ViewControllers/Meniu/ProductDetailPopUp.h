//
// ProductDetailPopUp.h
// Xpress Order
//
// Created by Constantin Saulenco on 11/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "BasePopUp.h"

@class FoodModel;
@class ProductDetailPopUp;

typedef NS_ENUM (NSInteger, DismissOption) {
	DismissOptionOk = 0,
	DismissOptionGoToTables
};
@protocol ProductDetailProtocol <NSObject>

- (void)productDetail:(ProductDetailPopUp *)popUp dismissedWithOption:(DismissOption)option;

@end

@interface ProductDetailPopUp: BasePopUp

@property (nonatomic, strong) FoodModel *selectedFoodModel;
@property (nonatomic, weak) IBOutlet UIImageView *imageViewProduct;
@property (nonatomic, weak) IBOutlet UILabel *labelDetails;
@property (nonatomic, weak) IBOutlet UIButton *buttonOK;
@property (nonatomic, weak) IBOutlet UIButton *buttonGoToTables;
@property (nonatomic, weak) id <ProductDetailProtocol> delegate;

- (instancetype)initWithNibName:(NSString *)nibName andFoodModel:(FoodModel *)foodModel;

@end