//
//  TableReservationPopUp.h
//  Xpress Order
//
//  Created by Constantin Saulenco on 11/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "BasePopUp.h"

@class  Table;
@class TableReservedPopUp;

typedef NS_ENUM(NSInteger, DismissOption) {
    DismissOptionPinSubmition = 0,
    DismissOptionMakeReservation
};

@protocol TableReservationProtocol <NSObject>

-(void) tableReservation:(TableReservedPopUp *)tablePopUp dismissedForOption:(DismissOption) dismissOption forTableView:(Table *) selectedTable;

@end

@interface TableReservedPopUp : BasePopUp

@property (nonatomic, strong) Table *selectedTable;
@property (nonatomic, strong) id <TableReservationProtocol> delegate;



@end
