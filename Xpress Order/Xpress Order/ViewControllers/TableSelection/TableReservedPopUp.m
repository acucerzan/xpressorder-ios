//
//  TableReservationPopUp.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 11/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableReservedPopUp.h"
#import "Table.h"
#import "ReservationCheck.h"

@interface TableReservedPopUp () < UITextFieldDelegate>
{
    
    __weak IBOutlet UILabel *labelTable;
    __weak IBOutlet UILabel *labelTableName;
    __weak IBOutlet UILabel *labelTableNumber;
    __weak IBOutlet UIView *viewTableContainer;
    __weak IBOutlet UIView *viewTableNumber;
    
    __weak IBOutlet UILabel *labelState;
    __weak IBOutlet UITextField *textFieldFirst;
    __weak IBOutlet UITextField *textFieldSecond;
    __weak IBOutlet UITextField *textFieldThird;
    __weak IBOutlet UITextField *textFieldFourth;
}

@end

@implementation TableReservedPopUp

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [labelTable setText:@"TABLE"];
    [labelTableName setText:self.selectedTable.table_id];
    [labelTableNumber setText:self.selectedTable.user_available];
    
    [labelState setText:self.selectedTable.user_state];
    
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [viewTableContainer.layer setCornerRadius:viewTableContainer.frame.size.height/2];
    
    [viewTableNumber.layer setCornerRadius:viewTableNumber.frame.size.height/2];
    [viewTableNumber.layer setBorderWidth:1];
    [viewTableNumber.layer setBorderColor:[UIColor whiteColor].CGColor];

    [textFieldFirst setDelegate:self];
    [textFieldSecond setDelegate:self];
    [textFieldThird setDelegate:self];
    [textFieldFourth setDelegate:self];
    
    [self addTapToQuit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkIfTableIsReservedInCaseNoneState
{
    MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
    [networkingDataSource checkIfReservedForPlaceWithId:self.selectedTable.place_id andTableNumber:self.selectedTable.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
        NSLog(@"Finished check table");
        if (items)
        {
            if (items.count > 0)
            {
                ReservationCheck *check = (ReservationCheck *)[items objectAtIndex:0];
                
                if (check.isReserved)
                {
                    NSLog(@"Masă rezervată pe data de %@ de la ora %@. Dacă totuși doriți să ocupați până atunci, introduceți codul pentru ocuparea mesei.", check.comingDate, check.arrivalTime);
                }
                else
                {
                    NSLog(@"Masă liberă. Te rugăm setează codul mesei pentru ocupare");
                }
            }
        }
    }];
}

- (void)checkIfTableIsReservedInCaseBusyState
{
    MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
    [networkingDataSource checkIfReservedForPlaceWithId:self.selectedTable.place_id andTableNumber:self.selectedTable.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
        NSLog(@"Finished check table");
        if (items)
        {
            if (items.count > 0)
            {
                NSLog(@"Masă ocupată pentru moment. Introdu codul mesei sau incercați la o masă liberă.");
            }
        }
    }];
}

- (void)checkIfTableIsReservedInCaseIsMyReservationState
{
//    MainNetworkingDataSource *networkingDataSource = [[XPModel sharedInstance] mainNetworkingDataSource];
//    [networkingDataSource checkIfReservedForPlaceWithId:self.selectedTable.place_id andTableNumber:self.selectedTable.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
//        NSLog(@"Finished check table");
//        if (items)
//        {
//            if (items.count > 0)
//            {
//                NSLog(@"Masă ocupată pentru moment. Introdu codul mesei sau incercați la o masă liberă.");
//            }
//        }
//    }];
}

- (void)takeTable:(Table *)table withPinCode:(NSString *)pinCode
{
    MainNetworkingDataSource *main = [[XPModel sharedInstance] mainNetworkingDataSource];
    [main takeTableWithPinCode:pinCode forPlaceID:table.place_id andTableNumber:table.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
        NSLog(@"Finished taking table");
        
        if (items)
        {
            [self compareCode:pinCode forTable:table];
        }
        
    }];
}

- (void)compareCode:(NSString *)code forTable:(Table *)table
{
    MainNetworkingDataSource *main = [[XPModel sharedInstance] mainNetworkingDataSource];
    [main comparePinCode:code forPlaceID:table.place_id andTableNumber:table.table_id withCompletitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
        NSLog(@"Finished comparing pin code for table: %@", table.table_id);
        
        if (error)
        {
            
        }
        else if (items)
        {
            if (items.count > 0)
            {
                TableAccess *tableAccess = [items objectAtIndex:0];
                
                table.tableAccess = tableAccess;
                
                NSLog(@"You have access to table %@ and order %@", table.table_id, tableAccess.orderID);
                
                // TODO open table view details
            }
        }
        
    }];
}

#pragma mark --- Button Action

- (IBAction)buttonSubmitPress:(id)sender
{
    NSLog(@"button submit Press");
    [self.delegate tableReservation:self dismissedForOption:DismissOptionPinSubmition forTableView:self.selectedTable];
}

- (IBAction)buttonMakeReservationPress:(id)sender
{
    NSLog(@"button make reservation press");
    [self.delegate tableReservation:self dismissedForOption:DismissOptionMakeReservation forTableView:self.selectedTable];
}



#pragma mark --- textfield Delegate 
#define kDelayForFirstResponder .1

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // if there is at least one char and the string is not an empty string then no change return NO
    if (textField.text.length ==1 && ![string isEqualToString:@""])
        return NO;
    
    if(textField == textFieldSecond && [string isEqualToString:@""])
    {
        [textFieldFirst performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayForFirstResponder];
    }
    if((textField == textFieldFirst && ![string isEqualToString:@""]) || (textField == textFieldThird && [string isEqualToString:@""]))
    {
        [textFieldSecond performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayForFirstResponder];
    }
    
    if((textField == textFieldSecond && ![string isEqualToString:@""]) || (textField == textFieldFourth && [string isEqualToString:@""]))
    {
        [textFieldThird performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayForFirstResponder];
    }
    
    if(textField == textFieldThird && ![string isEqualToString:@""])
    {
        [textFieldFourth performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:kDelayForFirstResponder];
    }
    
    if(textField == textFieldFourth && ![string isEqualToString:@""])
    {
        if(textFieldFourth.text.length >=1 && ![string isEqualToString:@""])
            return NO;
    }
    
    return YES;
}
@end
