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
//    [self.viewLeftTable.layer setCornerRadius:self.viewLeftTable.frame.size.height/2];
//    [self.viewLeftTableNumber.layer setCornerRadius:self.viewLeftTableNumber.frame.size.height/2];
//    [self.viewLeftTableState.layer setCornerRadius:self.viewLeftTableState.frame.size.height/2];
//    
//    [self.viewRightTable.layer setCornerRadius:self.viewRightTable.frame.size.height/2];
//    [self.viewRightTableState.layer setCornerRadius:self.viewRightTableState.frame.size.height/2];
//    [self.viewRightTableNumber.layer setCornerRadius:self.viewRightTableNumber.frame.size.height/2];
    
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
    
    NSString *imageTableState = @"";
    NSString *imageTableView = @"free_table";
    NSString *imagePersonNumber = @"number_of_ppl_purple";
    
    NSString *tableState = @"";
    [self.viewLeftTableState setHidden:YES];
    
    if([leftTable.user_state isEqualToString:@"busy"])
    {
        imageTableView = @"grey_table_big";
        imagePersonNumber = @"nr_of_person";
        imageTableState = @"busy_or_reserved";
        
        tableState = @"R";
        [self.viewLeftTableState setHidden:NO];
    }
    else
        if(leftTable.user_state !=nil)
    {
        imageTableView = @"grey_table_big";
        imagePersonNumber = @"grey_number_of_ppl";
        imageTableState = @"busy_or_reserved";
        
        tableState = @"R";
        [self.viewLeftTableState setHidden:NO];
    }

    
    
    [self.labelLeftPersonsNumber setText:[NSString stringWithFormat:@"x%@",table.user_available]];
    [self.labelLeftTableNumber setText:table.table_id];
    [self.labelLeftTableState setText:tableState];
    
    [self.imageViewLeftPersonNumer setImage:Image(imagePersonNumber)];
    [self.imageViewLeftTable setImage:Image(imageTableView)];
    [self.imageViewLeftTableState setImage:Image(imageTableState)];
    
    
    [self.viewContainerLeftTable setBackgroundColor:ClearColor];
    [self.viewLeftTableNumber setBackgroundColor:ClearColor];
    [self.viewLeftTableState setBackgroundColor:ClearColor];
    [self.viewLeftTable setBackgroundColor:ClearColor];
    
}

-(void) setRightTableViewWithTable:(Table *) table
{
    rightTable = table;
    
    NSString *imageTableState = @"";
    NSString *imageTableView = @"free_table";
    NSString *imagePersonNumber = @"number_of_ppl_purple";
    
    NSString *tableState = @"";
    [self.viewLeftTableState setHidden:YES];
    
    if([rightTable.user_state isEqualToString:@"busy"])
    {
        imageTableView = @"grey_table_big";
        imagePersonNumber = @"nr_of_person";
        imageTableState = @"busy_or_reserved";
        
        tableState = @"R";
        [self.viewLeftTableState setHidden:NO];
    }
    else
        if(rightTable.user_state !=nil && ![rightTable.user_state isEqualToString:@"none"])
        {
            imageTableView = @"grey_table_big";
            imagePersonNumber = @"grey_number_of_ppl";
            imageTableState = @"busy_or_reserved";
            
            tableState = @"R";
            [self.viewLeftTableState setHidden:NO];
        }


    
    
    [self.labelRightPersonsNumber setText:[NSString stringWithFormat:@"x%@",table.user_available]];
    [self.labelRightTableNumber setText:table.table_id];
    [self.labelRightTableState setText:tableState];
    
    [self.imageViewRightPersonNumber setImage:Image(imagePersonNumber)];
    [self.imageViewRightTable setImage:Image(imageTableView)];
    [self.imageViewRightTableState setImage:Image(imageTableState)];
    
    
    [self.viewContainerRightTable setBackgroundColor:ClearColor];
    [self.viewRightTableNumber setBackgroundColor:ClearColor];
    [self.viewRightTableState setBackgroundColor:ClearColor];
    [self.viewRightTable setBackgroundColor:ClearColor];
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
