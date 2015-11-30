//
//  EventsDataSource.h
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/08/14.
//

#import "LAbstractAFDataSource.h"

#import "ReservationRequest.h"

@interface MainNetworkingDataSource : LAbstractAFDataSource

- (void)getPlacesWithCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelPlacesRequest;


- (void)getTablesForPlaceWithId:(NSString *)placeID withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelTablesForPlaceWithIdRequest:(NSString *)placeID;


- (void)setReview:(NSNumber *)reviewValue forPlaceWithId:(NSString *)placeID withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelSetReviewRequest;


- (void)checkIfReservedForPlaceWithId:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelCheckIfReservedRequest;


//create_reservation.php cu parametrii place_id, table_no, name, emial, phone, coming_date, arriving_tie, nrpersoane, android_id(id de autentificare pe serverul gcm) , daca response ii 1 atunciastept 'pin' pe care il salvez in sqlite ca sa il pot afisa atunci cand intra la masa si ii rezervata masa de el, si afisez un dialog cu pinul.
//- (void)createReservation:(ReservationRequest *)reservationRequest withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
//- (void)cancelCreateReservationRequest;



@end
