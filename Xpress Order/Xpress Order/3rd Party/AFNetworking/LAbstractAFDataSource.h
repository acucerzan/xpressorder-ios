#import "AFHTTPRequestOperation.h"


typedef enum tagDataSourceError
{
    DataSourceErrorIncorrectRequestParameters,
    DataSourceErrorRequestCancelled,
    DataSourceErrorRequestFailed,
    DataSourceErrorRequestFailedWithNoCacheData,
    DataSourceErrorRequestFailedUsedStaleData
}DataSourceError;


@interface LAbstractAFDataSource : NSObject
{
    NSMutableDictionary *_requestsDict;
}


#pragma mark - Get data only


- (void)getDataWithOperation:(AFHTTPRequestOperation *)operation
           completitionBlock:(void(^)(NSData *data, NSError *error, NSDictionary *userInfo))completitionBlock;

- (void)getDataWithUrl:(NSString *)url
     completitionBlock:(void(^)(NSData *data, NSError *error, NSDictionary *userInfo))completitionBlock;


#pragma mark - Get and parse data


- (void)getDataWithOperation:(AFHTTPRequestOperation *)operation
             fallbackToCache:(BOOL)fallbackToCache
                 parserClass:(Class)parserClass
           completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;

- (void)getDataWithUrl:(NSString *)url
       fallbackToCache:(BOOL)fallbackToCache
           parserClass:(Class)parserClass
     completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;

- (void)getDataWithUrl:(NSString *)url
       timeoutInterval:(NSTimeInterval)timeoutInterval
               headers:(NSDictionary *)headers
            parameters:(NSDictionary *)params
         requestMethod:(NSString *)requestMethod
       fallbackToCache:(BOOL)fallbackToCache
           parserClass:(Class)parserClass
     completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock;


#pragma mark - Cancel


- (void)cancelOperationWithUrl:(NSString *)url;
- (void)cancelAllOperations;


#pragma mark - Create operation


+ (AFHTTPRequestOperation *)operationWithUrl:(NSString *)url
                             timeoutInterval:(NSTimeInterval)timeoutInterval
                                     headers:(NSDictionary *)headers
                                  parameters:(NSDictionary *)params
                               requestMethod:(NSString *)requestMethod;


#pragma mark -


@end