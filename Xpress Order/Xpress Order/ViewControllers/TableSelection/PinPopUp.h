//
// PinPopUp.h
// Xpress Order
//
// Created by Constantin Saulenco on 08/02/16.
// Copyright © 2016 Adrian Cucerzan. All rights reserved.
//

#import "BasePopUp.h"

@class PinPopUp;

@protocol PinPopUpProtocol <NSObject>

- (void)pinPopup:(PinPopUp *)pinPopUp dissmissedWithCode:(NSString *)code forTable:(Table *)selectedTable;

@end


@interface PinPopUp: BasePopUp
@property (nonatomic, strong) Table *selectedTable;
@property (nonatomic, strong) id <PinPopUpProtocol> delegate;
@end