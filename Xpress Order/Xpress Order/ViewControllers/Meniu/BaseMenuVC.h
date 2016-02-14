//
// BaseMenuVC.h
// Xpress Order
//
// Created by Constantin Saulenco on 11/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductGroupCell.h"
#import "ProductCell.h"
#import "ProductDetailPopUp.h"

@class Table;
@class CategoryModel;
@class FoodModel;

@interface BaseMenuVC: BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollViewCategory;
@property (nonatomic, weak) IBOutlet UITableView *tableViewProducts;
@property (weak, nonatomic) IBOutlet UILabel *labelCategoryName;

@property (nonatomic, strong) CategoryModel *selectedCategory;
@property (nonatomic, strong) NSArray <FoodModel *> *selectedFoods;
@property (nonatomic, strong) Table *selectedTable;
@property (nonatomic, strong) NSArray <CategoryModel *> *categoryList;
@property (nonatomic, strong) NSArray <CategoryModel *> *originalCategoryList;

- (instancetype)initWithNibName:(NSString *)nibName andSelectedTable:(Table *)table;

- (void)beforeDisplayingProductCell:(ProductCell *)cell;
- (void)reloadScrollView;

@end