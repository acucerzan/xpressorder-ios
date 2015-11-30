//
//  TableReservationPopUp.m
//  Xpress Order
//
//  Created by Constantin Saulenco on 11/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "TableReservationPopUp.h"
#import "Table.h"
#import "ReservationCheck.h"

@interface TableReservationPopUp () < UITextFieldDelegate>
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

@implementation TableReservationPopUp

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
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    [self applyMotionEffectsForView:self.viewContainer];
    
    [viewTableContainer.layer setCornerRadius:viewTableContainer.frame.size.height/2];
    
    [viewTableNumber.layer setCornerRadius:viewTableNumber.frame.size.height/2];
    [viewTableNumber.layer setBorderWidth:1];
    [viewTableNumber.layer setBorderColor:[UIColor whiteColor].CGColor];

    [textFieldFirst setDelegate:self];
    [textFieldSecond setDelegate:self];
    [textFieldThird setDelegate:self];
    [textFieldFourth setDelegate:self];
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

#pragma mark --- Helper Function

-(void)showPopUpInViewController:(UIViewController *)viewController
{
    self.view.frame = viewController.view.frame;
    
    [self.view setAlpha:0];
    
    [viewController.navigationController addChildViewController:self];
    [viewController.navigationController.view addSubview:self.view];
    
    [self didMoveToParentViewController:self];
    
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
         self.view.alpha = 1;
     }
                     completion:^(BOOL finished) {
                         if(finished)
                         {
                             [self viewWillAppear:YES];
                         }
                     }];

}

-(void) closePopUp
{
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.view.alpha = 0;
         self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
     }completion:^(BOOL finished)
     {
         [self removeFromParentViewController];
         [self.view removeFromSuperview];
         
     }];

}

#define  kCustomIOS7MotionEffectExtent 20.0

- (void)applyMotionEffectsForView:(UIView *) view
{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        return;
    }
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-kCustomIOS7MotionEffectExtent);
    horizontalEffect.maximumRelativeValue = @( kCustomIOS7MotionEffectExtent);
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-kCustomIOS7MotionEffectExtent);
    verticalEffect.maximumRelativeValue = @( kCustomIOS7MotionEffectExtent);
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [view addMotionEffect:motionEffectGroup];
    
}

#pragma mark --- textfield Delegate 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == textFieldFirst)
    {
        [textFieldSecond performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:.5];
    }
    
    if(textField == textFieldSecond)
    {
        [textFieldThird performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:.5];
    }
    
    if(textField == textFieldThird)
    {
        [textFieldFourth performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:.5];
    }
    
    if(textField == textFieldFourth)
    {
        if(textFieldFourth.text.length >=1 && ![string isEqualToString:@""])
            return NO;
    }
    
    return YES;
}
@end
