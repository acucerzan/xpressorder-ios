//
//  TableSelectionCell.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 09/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Table;

#define kTableSelectionCellHeight 180

@interface TableSelectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewContainerLeftTable;
@property (weak, nonatomic) IBOutlet UIView *viewLeftTable;
@property (weak, nonatomic) IBOutlet UIView *viewLeftTableState;
@property (weak, nonatomic) IBOutlet UIView *viewLeftTableNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftTable;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftTableNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftTableState;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftPersonsNumber;

@property (weak, nonatomic) IBOutlet UIView *viewContainerRightTable;
@property (weak, nonatomic) IBOutlet UIView *viewRightTable;
@property (weak, nonatomic) IBOutlet UIView *viewRightTableState;
@property (weak, nonatomic) IBOutlet UIView *viewRightTableNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelRightTable;
@property (weak, nonatomic) IBOutlet UILabel *labelRightTableNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelRightTableState;
@property (weak, nonatomic) IBOutlet UILabel *labelRightPersonsNumber;

@property (nonatomic, strong) void (^buttonTablePress)(Table *selectedTable);

-(void) refreshCell;
-(void) setLeftTableViewWithTable:(Table *) table;
-(void) setRightTableViewWithTable:(Table *) table;

@end
