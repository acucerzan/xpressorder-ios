//
// EventsDataSource.h
// XpressOrder
//
// Created by Adrian Cucerzan on 22/08/14.
//

#import "LAbstractAFDataSource.h"

@class Reservation;

@interface MainNetworkingDataSource: LAbstractAFDataSource

/**
 *  get place request
 *
 *  @param completitionBlock competition block with Array of Cafe objects error , and user info dictionary
 */
- (void)getPlacesWithCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelPlacesRequest;

/**
 *  get the table for a place id that is given as parameter
 *
 *  @param placeID           NSString place id
 *  @param completitionBlock completition block with NSarray of Table object, error, and user info dictionary
 */
- (void)getTablesForPlaceWithId:(NSString *)placeID withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelTablesForPlaceWithIdRequest:(NSString *)placeID;

/**
 *  set the review (1 to 5) to a place id given as parameter
 *
 *  @param reviewValue       NSNumber with float value [1,5]
 *  @param placeID           NSString place id
 *  @param completitionBlock completition block with Result
 */
- (void)setReview:(NSNumber *)reviewValue forPlaceWithId:(NSString *)placeID withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelSetReviewRequest;


- (void)checkIfReservedForPlaceWithId:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelCheckIfReservedRequest;


- (void)comparePinCode:(NSString *)pinCode forPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelComparePinCodeRequest;

- (void)takeTableWithPinCode:(NSString *)pinCode forPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelTakeTableWithPinCodeRequest;

/**
 *   create_reservation.php cu parametrii place_id, table_no, name, emial, phone, coming_date, arriving_tie, nrpersoane, android_id(id de
 * autentificare
 *  pe serverul gcm) , daca response ii 1 atunciastept 'pin' pe care il salvez in sqlite ca sa il pot afisa atunci cand intra la masa si ii rezervata
 *  masa de el, si afisez un dialog cu pinul.
 *
 *  @param reservation       Reservation object
 *  @param completitionBlock return block
 */
- (void)createReservation:(Reservation *)reservation withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelCreateReservationRequest;


- (void)callWaitressforPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelCallWaitressRequest;


- (void)getCategoryFoodforPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelCategoryFoodRequest;


- (void)getFoodFromOrderID:(NSString *)orderID withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelFoodFromOrderRequest;

- (void)addProductID:(NSString *)foodID toOrderID:(NSString *)orderID withObservation:(NSString *)observationsString withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelAddOrderRequest;

- (void)getFoodOrderForOrderId:(NSString *)orderId withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelGetFoodForOrder;


@end