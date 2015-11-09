//
//  TableSelectionCell.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 09/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableSelectionCell.h"
#import "Table.h"

@implementation TableSelectionCell

- (void)awakeFromNib
{
    // Initialization code
    [self.viewLeftTable.layer setCornerRadius:self.viewLeftTable.frame.size.height/2];
    [self.viewLeftTableNumber.layer setCornerRadius:self.viewLeftTableNumber.frame.size.height/2];
    [self.viewLeftTableState.layer setCornerRadius:self.viewLeftTableState.frame.size.height/2];
    
    [self.viewRightTable.layer setCornerRadius:self.viewRightTable.frame.size.height/2];
    [self.viewRightTableState.layer setCornerRadius:self.viewRightTableState.frame.size.height/2];
    [self.viewRightTableNumber.layer setCornerRadius:self.viewRightTableNumber.frame.size.height/2];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --- Helper Functions

-(void) refreshCell
{
    [self.viewContainerRightTable setHidden:NO];
    [self.viewContainerLeftTable setHidden:NO];
}
-(void) setLeftTableViewWithTable:(Table *) table
{
    //TODO:implement this method
    [self.labelLeftPersonsNumber setText:@"x4"];
    [self.labelLeftTableNumber setText:@"1"];
    [self.labelLeftTableState setText:@"BUSY"];
}
-(void) setRightTableViewWithTable:(Table *) table
{
     //TODO:implement this method
    [self.labelRightPersonsNumber setText:@"x4"];
    [self.labelRightTableNumber setText:@"1"];
    [self.labelRightTableState setText:@"BUSY"];
}
@end
