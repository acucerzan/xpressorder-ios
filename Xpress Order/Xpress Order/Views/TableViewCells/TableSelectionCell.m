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
{
    Table *leftTable;
    Table *rightTable;
}

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
    leftTable = table;
    [self.labelLeftPersonsNumber setText:[NSString stringWithFormat:@"x%@",table.user_available]];
    [self.labelLeftTableNumber setText:table.table_id];
    [self.labelLeftTableState setText:table.user_state];
    
    [self.viewContainerLeftTable setBackgroundColor:[UIColor clearColor]];
}

-(void) setRightTableViewWithTable:(Table *) table
{
    rightTable = table;
    [self.labelRightPersonsNumber setText:[NSString stringWithFormat:@"x%@",table.user_available]];
    [self.labelRightTableNumber setText:table.table_id];
    [self.labelRightTableState setText:table.user_state];
    
    [self.viewContainerRightTable setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)buttonLeftTablePress:(id)sender
{
    if(self.buttonTablePress)
        self.buttonTablePress(leftTable);
}

- (IBAction)buttonRightTablePress:(id)sender
{
    self.buttonTablePress(rightTable);
}

@end
