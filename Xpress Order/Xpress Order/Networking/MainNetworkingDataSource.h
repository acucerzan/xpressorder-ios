//
//  EventsDataSource.h
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/08/14.
//

#import "LAbstractAFDataSource.h"

@interface MainNetworkingDataSource : LAbstractAFDataSource

- (void)getPlacesWithCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelPlacesRequest;

- (void)getTablesForPlaceWithId:(NSString *)placeID withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelTablesForPlaceWithIdRequest:(NSString *)placeID;


- (void)setReview:(NSNumber *)reviewValue forPlaceWithId:(NSString *)placeID withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;
- (void)cancelSetReviewRequest;

@end
