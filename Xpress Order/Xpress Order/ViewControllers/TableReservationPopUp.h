//
//  TableReservationPopUp.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 11/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  Table;
@class TableReservationPopUp;

typedef NS_ENUM(NSInteger, DismissOption) {
    DismissOptionPinSubmition = 0,
    DismissOptionMakeReservation
};

@protocol TableReservationProtocol <NSObject>

-(void) tableReservation:(TableReservationPopUp *)tablePopUp dismissedForOption:(DismissOption) dismissOption forTableView:(Table *) selectedTable;

@end

@interface TableReservationPopUp : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (nonatomic, strong) Table *selectedTable;
@property (nonatomic, strong) id <TableReservationProtocol> delegate;

-(void) showPopUpInViewController:(UIViewController *) viewController;
-(void) closePopUp;

@end
