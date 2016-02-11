//
// ProductCell.h
// Xpress Order
//
// Created by Constantin Saulenco on 20/11/15.
// Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

#define kProductCellHeight 151

typedef NS_ENUM (NSInteger, ProductCellType) {
	ProductCellTypeNonOrder = 0,
	ProductCellTypeOrder
};

@interface ProductCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (weak, nonatomic) IBOutlet UIView *viewContainerOrder;
@property (weak, nonatomic) IBOutlet UILabel *labelProductname;
@property (weak, nonatomic) IBOutlet UIButton *buttonOrder;
@property (weak, nonatomic) IBOutlet UIView *viewLabelSeparator;

- (void)setProductCellType:(ProductCellType)productCellType;

@end