//
// EventsDataSource.m
// XpressOrder
//
// Created by Adrian Cucerzan on 22/08/14.
//

#import "MainNetworkingDataSource.h"
#import "PlaceListParser.h"
#import "TablesParser.h"
#import "SetReviewParser.h"
#import "CheckReservationParser.h"
#import "CheckTableCodeParser.h"
#import "CompareTableCodeParser.h"
#import "CallWaitressParser.h"
#import "CategoryFoodsParser.h"
#import "MyFoodsParser.h"
#import "TakeTableParser.h"
#import "AddToOrderParser.h"

#import "AFNetworkReachabilityManager.h"


#import "Reservation.h"

// #define URL_SERVER @"http://coffee.dahuasoft2008.com/api/"
#define URL_SERVER @"http://www.coffeeapp.club/api/"

#define kDefaultTimeOut 30

// MARK: requests
#define kRequestReservation      @"create_reservation.php"
#define kRequestGetTableList     @"get_table_list.php"
#define KRequestGetPlaceList     @"get_place_list.php"
#define kRequestSetReview        @"set_review.php"
#define kRequestCheckReservation @"reservation_time.php"
#define kRequestComparePinCode   @"compare_pincode.php"
#define kRequestTakeTable        @"table_sit.php"
#define kRequestGetCategoryFood  @"get_category_food.php"
#define kRequestGetFoodOrder     @"get_food_order.php"

// MARK: request Params
#define kParamPlaceId       @"place_id"
#define kParamName          @"Name"
#define kParamEmail         @"Email"
#define kParamPhone         @"Phone"
#define kParamComingDate    @"Coming_date"
#define kParamArrivingTime  @"Arriving_time"
#define kParamPersonsCount  @"Nrpersoane"
#define kParamAndroidId     @"Android_id"
#define kParamObservations  @"Observatii"
#define kParamTableNomber   @"table_no"
#define kParamPlaceReview   @"place_review"
#define kParamReservationId @"reservation_id"
#define kParamOrderId       @"order_id"


@implementation MainNetworkingDataSource

- (id)init
{
	self = [super init];

	if (self)
		// start reachability monitor
		[[AFNetworkReachabilityManager sharedManager] startMonitoring];

	return self;
}

- (NSString *)getPlacesURL
{
	NSString *str = [URL_SERVER stringByAppendingString:KRequestGetPlaceList];

	return str;
}

- (void)getPlacesWithCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
// if (![AFNetworkReachabilityManager sharedManager].reachable) {
// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
// return;
// }

	NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
	                         @"application/json", @"Content-type",
	                         nil];


// NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
// nil];

	[self getDataWithUrl:[self getPlacesURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:headers
	          parameters:nil  // params
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
	NSString *str = [URL_SERVER stringByAppendingString:kRequestGetTableList];

	return str;
}

- (void)getTablesForPlaceWithId:(NSString *)placeID withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
// if (![AFNetworkReachabilityManager sharedManager].reachable) {
// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
// return;
// }


	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               placeID, kParamPlaceId,
	                               nil];

	[self getDataWithUrl:[self getTablesURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
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
	NSString *str = [URL_SERVER stringByAppendingString:kRequestSetReview];

	return str;
}

- (void)setReview:(NSNumber *)reviewValue forPlaceWithId:(NSString *)placeID withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	// if (![AFNetworkReachabilityManager sharedManager].reachable) {
	// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
	// return;
	// }

	NSString *reviewString = [NSString stringWithFormat:@"%.2f", [reviewValue floatValue]];

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               placeID, kParamPlaceId,
	                               reviewString, kParamPlaceReview,
	                               nil];

	[self getDataWithUrl:[self getSetReviewURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
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

- (NSString *)getCheckReserved
{
	NSString *str = [URL_SERVER stringByAppendingString:kRequestCheckReservation];

	return str;
}

- (void)checkIfReservedForPlaceWithId:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
// if (![AFNetworkReachabilityManager sharedManager].reachable) {
// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
// return;
// }

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               placeID, kParamPlaceId,
	                               tableNr, kParamTableNomber,
	                               nil];

	[self getDataWithUrl:[self getCheckReserved]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[CheckReservationParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelCheckIfReservedRequest
{
	[self cancelOperationWithUrl:[self getCheckReserved]];
}

// - (NSString *)getCheckPinCodeURL
// {
// NSString *str = [URL_SERVER stringByAppendingString:@"reservation_time.php"];
//
// return str;
// }
//
// - (void)checkPinCode:(NSString *)pinCode forPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void(^)(NSArray
// *items, NSError *error, NSDictionary *userInfo))completitionBlock
// {
////    if (![AFNetworkReachabilityManager sharedManager].reachable) {
////        completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil],
/// nil);
////        return;
////    }
//
// NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
// pinCode, @"pin_code",
// placeID, kParamPlaceId,
// tableNr, kParamTableNomber,
// nil];
//
// [self getDataWithUrl:[self getCheckPinCodeURL]
// timeoutInterval:kDefaultTimeOut
// headers:nil//headers
// parameters:params
// requestMethod:@"POST"
// fallbackToCache:NO
// parserClass:[CheckTableCodeParser class]
// completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
// completitionBlock(items, error, userInfo);
// }];
// }
//
// - (void)cancelCheckPinCodeRequest
// {
// [self cancelOperationWithUrl:[self getCheckPinCodeURL]];
// }


- (NSString *)comparePinCodeURL
{
	NSString *str = [URL_SERVER stringByAppendingString:kRequestComparePinCode];

	return str;
}

- (void)comparePinCode:(NSString *)pinCode forPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	// if (![AFNetworkReachabilityManager sharedManager].reachable) {
	// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
	// return;
	// }

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               pinCode, @"pin_code",
	                               placeID, kParamPlaceId,
	                               tableNr, kParamTableNomber,
	                               nil];

	[self getDataWithUrl:[self comparePinCodeURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[CompareTableCodeParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelComparePinCodeRequest
{
	[self cancelOperationWithUrl:[self comparePinCodeURL]];
}

- (NSString *)takeTableURL
{
	NSString *str = [URL_SERVER stringByAppendingString:kRequestTakeTable];

	return str;
}

- (void)takeTableWithPinCode:(NSString *)pinCode forPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	// if (![AFNetworkReachabilityManager sharedManager].reachable) {
	// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
	// return;
	// }

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               pinCode, @"pin",
	                               placeID, kParamPlaceId,
	                               tableNr, kParamTableNomber,
	                               [NSString stringWithFormat:@"name+%@", tableNr], @"name",
	                               @"email-busy", @"email",
	                               @"numar-busy", @"phone",
	                               @"email-busy", @"coming_date",
	                               @"email-busy", @"arriving_time",
	                               nil];

	[self getDataWithUrl:[self takeTableURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[TakeTableParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelTakeTableWithPinCodeRequest
{
	[self cancelOperationWithUrl:[self takeTableURL]];
}

- (void)createReservation:(Reservation *)reservation withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
	[dateFormater setDateFormat:@"yyyy-mm-dd"];

	NSDateFormatter *timeFormater = [[NSDateFormatter alloc] init];
	[timeFormater setDateFormat:@"HH:mm"];

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
	                               @{ kParamPlaceId: reservation.place.place_id,
	                                  kParamName: reservation.clientName,
	                                  kParamEmail: reservation.clientEmail,
	                                  kParamPhone: reservation.clientPhone,
	                                  kParamComingDate: [dateFormater stringFromDate:reservation.clientDate],
	                                  kParamArrivingTime: [timeFormater stringFromDate:reservation.clientDate],
	                                  kParamPersonsCount: reservation.personCount,
	                                  kParamAndroidId: @"--",
	                                  kParamObservations: reservation.clientObservation }];

	[self getDataWithUrl:[URL_SERVER stringByAppendingString:kRequestReservation]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[TakeTableParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelCreateReservationRequest
{
	[self cancelOperationWithUrl:[URL_SERVER stringByAppendingString:kRequestReservation]];
}

- (NSString *)getCallWaitressURL
{
	NSString *str = [URL_SERVER stringByAppendingString:@"call.php"];

	return str;
}

- (void)callWaitressforPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
// if (![AFNetworkReachabilityManager sharedManager].reachable) {
// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
// return;
// }

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               placeID, kParamPlaceId,
	                               tableNr, kParamTableNomber,
	                               nil];

	[self getDataWithUrl:[self getCallWaitressURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[CallWaitressParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelCallWaitressRequest
{
	[self cancelOperationWithUrl:[self getCallWaitressURL]];
}

- (NSString *)getCategoryFoodURL
{
	NSString *str = [URL_SERVER stringByAppendingString:kRequestGetCategoryFood];

	return str;
}

- (void)getCategoryFoodforPlaceID:(NSString *)placeID andTableNumber:(NSString *)tableNr withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	// if (![AFNetworkReachabilityManager sharedManager].reachable) {
	// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
	// return;
	// }

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               placeID, kParamPlaceId,
	                               tableNr, kParamTableNomber,
	                               nil];

	[self getDataWithUrl:[self getCategoryFoodURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[CategoryFoodsParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelCategoryFoodRequest
{
	[self cancelOperationWithUrl:[self getCategoryFoodURL]];
}

- (NSString *)addOrderURL
{
	NSString *str = [URL_SERVER stringByAppendingString:@"create_food_order.php"];

	return str;
}

- (void)addProductID:(NSString *)foodID toOrderID:(NSString *)orderID withObservation:(NSString *)observationsString withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	// if (![AFNetworkReachabilityManager sharedManager].reachable) {
	// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
	// return;
	// }

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               orderID, kParamOrderId,
	                               foodID, @"food_id",
	                               @"pushToken", @"",
	                               observationsString, @"observatii",
	                               nil];

	[self getDataWithUrl:[self addOrderURL]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil  // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[AddToOrderParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelAddOrderRequest
{
	[self cancelOperationWithUrl:[self addOrderURL]];
}

// - (NSString *)getMyFoodURL
// {
// NSString *str = [URL_SERVER stringByAppendingString:@"get_food_like.php"];
//
// return str;
// }
//
// - (void)getFoodFromOrderID:(NSString *)orderID withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary
// *userInfo))completitionBlock
// {
//// if (![AFNetworkReachabilityManager sharedManager].reachable) {
//// completitionBlock([NSMutableArray arrayWithCapacity:0], [NSError errorWithDomain:lang(@"no_internet_connection") code:-1 userInfo:nil], nil);
//// return;
//// }
//
// NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
// orderID, kParamReservationId,
// nil];
//
// [self getDataWithUrl:[self getMyFoodURL]
// timeoutInterval:kDefaultTimeOut
// headers:nil  // headers
// parameters:params
// requestMethod:@"POST"
// fallbackToCache:NO
// parserClass:[MyFoodsParser class]
// completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
// completitionBlock(items, error, userInfo);
// }];
// }
//
// - (void)cancelFoodFromOrderRequest
// {
// [self cancelOperationWithUrl:[self getMyFoodURL]];
// }

- (void)getFoodOrderForOrderId:(NSString *)orderId withCompletitionBlock:(void (^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
	                               orderId, kParamOrderId,
	                               nil];

	[self getDataWithUrl:[URL_SERVER stringByAppendingString:kRequestGetFoodOrder]
	     timeoutInterval:kDefaultTimeOut
	             headers:nil    // headers
	          parameters:params
	       requestMethod:@"POST"
	     fallbackToCache:NO
	         parserClass:[MyFoodsParser class]
	   completitionBlock:^(NSArray *items, NSError *error, NSDictionary *userInfo) {
	  completitionBlock(items, error, userInfo);
	}];
}

- (void)cancelGetFoodForOrder
{
	[self cancelOperationWithUrl:[URL_SERVER stringByAppendingString:kRequestGetFoodOrder]];
}

@end