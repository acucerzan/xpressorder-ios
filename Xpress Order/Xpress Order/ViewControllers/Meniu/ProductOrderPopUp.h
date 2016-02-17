//
// ProductOrderPopUp.h
// Xpress Order
//
// Created by Constantin Saulenco on 15/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "BasePopUp.h"

@class ProductOrderPopUp;

@protocol ProductOrderProtocol <NSObject>

- (void)productOrder:(ProductOrderPopUp *)popUp dismissedWithOption:(DismissOption)option forFood:(FoodModel *)food andObservation:(NSString *)observations;

@end

@interface ProductOrderPopUp: BasePopUp

@property (nonatomic, strong) FoodModel *selectedFoodModel;
@property (nonatomic, weak) IBOutlet UIImageView *imageViewProduct;
@property (nonatomic, weak) IBOutlet UILabel *labelDetails;
@property (nonatomic, weak) IBOutlet UILabel *labelObservation;
@property (nonatomic, weak) IBOutlet UIButton *buttonOK;
@property (nonatomic, weak) IBOutlet UIButton *buttonAction;
@property (nonatomic, weak) id <ProductOrderProtocol> delegate;
@property (weak, nonatomic) IBOutlet UITextView *textViewObservations;

@property (nonatomic, strong) NSString *actionButtonTitle;

- (instancetype)initWithNibName:(NSString *)nibName andFoodModel:(FoodModel *)foodModel;

@end