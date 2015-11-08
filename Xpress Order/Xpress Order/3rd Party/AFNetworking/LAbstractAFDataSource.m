#import "LAbstractAFDataSource.h"
#import "LParserInterface.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"


@implementation LAbstractAFDataSource


#pragma mark - Init


- (id)init
{
    self = [super init];
    if (self)
    {
        _requestsDict = [NSMutableDictionary new];
    }
    return self;
}


#pragma mark - Get data only


- (void)getDataWithOperation:(AFHTTPRequestOperation *)operation
           completitionBlock:(void(^)(NSData *data, NSError *error, NSDictionary *userInfo))completitionBlock
{
    if (!operation || !operation.request.URL)
    {
        completitionBlock(nil, [NSError errorWithDomain:@"Request is null. Incorrect request parameters?" code:DataSourceErrorIncorrectRequestParameters userInfo:nil], nil);
    }
    else
    {
        [self cancelOperationWithUrl:[operation.request.URL absoluteString]];
        
        __weak AFHTTPRequestOperation *op = operation;
        
        void (^opCompletitionBlock)(AFHTTPRequestOperation *afOperation) = ^(AFHTTPRequestOperation *afOperation) {
            [_requestsDict removeObjectForKey:[operation.request.URL absoluteString]];
            completitionBlock(operation.responseData, operation.error, [operation.response allHeaderFields]);
        };
        
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            opCompletitionBlock(op);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            opCompletitionBlock(op);
        }];
        
        [op start];
    }
}


- (void)getDataWithUrl:(NSString *)url
     completitionBlock:(void(^)(NSData *data, NSError *error, NSDictionary *userInfo))completitionBlock
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [self getDataWithOperation:operation completitionBlock:completitionBlock];
}


#pragma mark - Get and parse data


- (void)getDataWithOperation:(AFHTTPRequestOperation *)operation
             fallbackToCache:(BOOL)fallbackToCache
                 parserClass:(Class)parserClass
           completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
    if (!operation || !operation.request.URL)
    {
        completitionBlock(nil, [NSError errorWithDomain:@"Request is null. Incorrect request parameters?" code:DataSourceErrorIncorrectRequestParameters userInfo:nil], nil);
    }
    else
    {
        [self cancelOperationWithUrl:[operation.request.URL absoluteString]];
        
        __weak LAbstractAFDataSource *weakSelf = self;
        __weak AFHTTPRequestOperation *op = operation;
        
        void (^opCompletitionBlock)(AFHTTPRequestOperation *afOperation) = ^(AFHTTPRequestOperation *afOperation) {
            [_requestsDict removeObjectForKey:[operation.request.URL absoluteString]];
            [weakSelf didFinishOperation:afOperation fallbackToCache:fallbackToCache parserClass:parserClass completitionBlock:completitionBlock];
        };
        
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            opCompletitionBlock(op);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            opCompletitionBlock(op);
        }];
        
        [op start];
    }
}


- (void)getDataWithUrl:(NSString *)url
       fallbackToCache:(BOOL)fallbackToCache
           parserClass:(Class)parserClass
     completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [self getDataWithOperation:operation
               fallbackToCache:fallbackToCache
                   parserClass:parserClass
             completitionBlock:completitionBlock];
}


- (void)getDataWithUrl:(NSString *)url
       timeoutInterval:(NSTimeInterval)timeoutInterval
               headers:(NSDictionary *)headers
            parameters:(NSDictionary *)params
         requestMethod:(NSString *)requestMethod
       fallbackToCache:(BOOL)fallbackToCache
           parserClass:(Class)parserClass
     completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
    AFHTTPRequestOperation *op = [LAbstractAFDataSource operationWithUrl:url
                                                         timeoutInterval:timeoutInterval
                                                                 headers:headers
                                                              parameters:params
                                                           requestMethod:requestMethod];
    
    [self getDataWithOperation:op fallbackToCache:fallbackToCache parserClass:parserClass completitionBlock:completitionBlock];
}


#pragma mark - Parse data


- (void)didFinishOperation:(AFHTTPRequestOperation *)operation
           fallbackToCache:(BOOL)fallbackToCache
               parserClass:(Class)parserClass
         completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
    __weak LAbstractAFDataSource *weakSelf = self;
    
    if (operation.error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([operation isCancelled])
            {
                completitionBlock(nil, [NSError errorWithDomain:@"Data request cancelled" code:DataSourceErrorRequestCancelled userInfo:nil], [operation.response allHeaderFields]);
            }
            else
            {
                if (fallbackToCache)
                {
                    NSCachedURLResponse *cachedResp = [[NSURLCache sharedURLCache] cachedResponseForRequest:operation.request];
                    
                    if (cachedResp && cachedResp.data)
                    {
                        [weakSelf parseOperationData:cachedResp.data
                                    usingParserClass:parserClass
                                     didUseStaleData:YES
                                            userInfo:[operation.response allHeaderFields]
                                   completitionBlock:completitionBlock];
                    }
                    else
                    {
                        completitionBlock(nil, [NSError errorWithDomain:@"Data request failed with no cached data." code:DataSourceErrorRequestFailedWithNoCacheData userInfo:nil], [operation.response allHeaderFields]);
                    }
                }
                else
                {
                    if ([operation.error.domain isEqualToString:@"AFNetworkingErrorDomain"] || [operation.error.domain isEqualToString:@"NSURLErrorDomain"])
                    {
                        completitionBlock(nil, [NSError errorWithDomain:@"cannot_communicate_with_server" code:DataSourceErrorRequestFailed userInfo:nil], [operation.response allHeaderFields]);
                    }
                    else
                    {
                        completitionBlock(nil, [NSError errorWithDomain:operation.error.domain code:DataSourceErrorRequestFailed userInfo:nil], [operation.response allHeaderFields]);
                    }
//                    completitionBlock(nil, [NSError errorWithDomain:lang(@"no_internet_connection") code:DataSourceErrorRequestFailed userInfo:nil], [operation.response allHeaderFields]);
                }
            }
        });
    }
    else
    {
        [weakSelf parseOperationData:operation.responseData
                    usingParserClass:parserClass
                     didUseStaleData:NO
                            userInfo:[operation.response allHeaderFields]
                   completitionBlock:completitionBlock];
    }
}


- (void)parseOperationData:(NSData *)data
          usingParserClass:(Class)parserClass
           didUseStaleData:(BOOL)didUseStaleData
                  userInfo:(NSDictionary *)userInfo
         completitionBlock:(void(^)(NSArray *items, NSError *error, NSDictionary *userInfo))completitionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id <LParserInterface> parser = [parserClass new];
        [parser parseData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (parser.error)
            {
                NSLog(@"PARSER ERROR");
                completitionBlock(nil, parser.error, userInfo);
            }
            else
            {
//                NSLog(@"PARSER SUCCESS");
                completitionBlock(parser.itemsArray, didUseStaleData ? [NSError errorWithDomain:@"Did use stale data." code:DataSourceErrorRequestFailedUsedStaleData userInfo:nil] : nil, userInfo);
            }
        });
    });
}


#pragma mark - Cancel requests


- (void)cancelOperationWithUrl:(NSString *)url
{
    if (!url) return;
    
    AFHTTPRequestOperation *operation = [_requestsDict objectForKey:url];
    [operation cancel];
    [_requestsDict removeObjectForKey:url];
}


- (void)cancelAllOperations
{
    for (AFHTTPRequestOperation *operation in [_requestsDict allValues])
    {
        [operation cancel];
    }
    
    [_requestsDict removeAllObjects];
}


#pragma mark - Create request


+ (AFHTTPRequestOperation *)operationWithUrl:(NSString *)url
                             timeoutInterval:(NSTimeInterval)timeoutInterval
                                     headers:(NSDictionary *)headers
                                  parameters:(NSDictionary *)params
                               requestMethod:(NSString *)requestMethod
{
    NSURL *URL = [NSURL URLWithString:url];
    
    NSString *baseUrl = [[URL URLByDeletingLastPathComponent] absoluteString];
    NSString *lastPathComponent = [URL lastPathComponent];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    
    NSMutableURLRequest *request = [client requestWithMethod:requestMethod path:lastPathComponent parameters:params];
    request.timeoutInterval = timeoutInterval;
    
    for (NSString *header in [headers allKeys])
        [request addValue:[headers valueForKey:header] forHTTPHeaderField:header];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    return op;
}


#pragma mark - dealloc


- (void)dealloc
{
    [self cancelAllOperations];
}


#pragma mark -


@end