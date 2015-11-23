//
//  EventsDataSource.m
//  XpressOrder
//
//  Created by Adrian Cucerzan on 22/08/14.
//

#import "MainNetworkingDataSource.h"
#import "PlaceListParser.h"
#import "TablesParser.h"
#import "SetReviewParser.h"

#import "AFNetworkReachabilityManager.h"

//#define URL_SERVER @"http://coffee.dahuasoft2008.com/api/"
#define URL_SERVER @"http://www.coffeeapp.club/api/"
//#define URL_SERVER @"http://192.168.1.115/API/"

@implementation MainNetworkingDataSource

- (id)init
{
    self = [super init];
    
    if (self)
    {
        // start reachability monitor
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    
    return self;
}

- (NSString *)getPlacesURL
{
    NSString *str = [URL_SERVER stringByAppendingString:@"get_place_list.php"];
    
    return str;
}

- (void)getPlacesWithCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
//    if (![AFNetworkReachabilityManager sharedManager].reachable) {
//        completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
//        return;
//    }
    
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"application/json", @"Content-type",
                             nil];
    
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   nil];
    
    [self getDataWithUrl:[self getPlacesURL]
         timeoutInterval:30
                 headers:headers
              parameters:nil//params
           requestMethod:@"GET"
         fallbackToCache:NO
             parserClass:[PlaceListParser class]
       completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
           completitionBlock(items, error, userInfo);
       }];
}

- (void)cancelPlacesRequest
{
    [self cancelOperationWithUrl:[self getPlacesURL]];
}

- (NSString *)getTablesURL
{
    NSString *str = [URL_SERVER stringByAppendingString:@"get_table_list.php"];
    
    return str;
}

- (void)getTablesForPlaceWithId:(NSString *)placeID withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
//    if (![AFNetworkReachabilityManager sharedManager].reachable) {
//        completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
//        return;
//    }
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   placeID, @"place_id",
                                   nil];
    
    [self getDataWithUrl:[self getTablesURL]
         timeoutInterval:30
                 headers:nil//headers
              parameters:params
           requestMethod:@"POST"
         fallbackToCache:NO
             parserClass:[TablesParser class]
       completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
           completitionBlock(items, error, userInfo);
       }];
}

- (void)cancelTablesForPlaceWithIdRequest:(NSString *)placeID
{
    [self cancelOperationWithUrl:[self getTablesURL]];
}

- (NSString *)getSetReviewURL
{
    NSString *str = [URL_SERVER stringByAppendingString:@"set_review.php"];
    
    return str;
}

- (void)setReview:(NSNumber *)reviewValue forPlaceWithId:(NSString *)placeID withCompletitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
    //    if (![AFNetworkReachabilityManager sharedManager].reachable) {
    //        completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
    //        return;
    //    }
    
    NSString *reviewString = [NSString stringWithFormat:@"%.2f", [reviewValue floatValue]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   placeID, @"place_id",
                                   reviewString, @"place_review",
                                   nil];
    
    [self getDataWithUrl:[self getSetReviewURL]
         timeoutInterval:30
                 headers:nil//headers
              parameters:params
           requestMethod:@"POST"
         fallbackToCache:NO
             parserClass:[SetReviewParser class]
       completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
           completitionBlock(items, error, userInfo);
       }];
}
- (void)cancelSetReviewRequest
{
    [self cancelOperationWithUrl:[self getSetReviewURL]];
}

@end
