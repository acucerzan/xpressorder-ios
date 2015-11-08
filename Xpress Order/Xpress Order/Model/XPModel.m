//
//  XPModel.m
//  XpressOrder
//
//  Created by Adrian Cucerzan on 1/08/14.
//

#import "XPModel.h"

@interface XPModel ()
{
}

@property (nonatomic, retain) MainNetworkingDataSource *networkingDataSource;

@end

@implementation XPModel

@synthesize isInternetActive, currentiPhoneScreenSize, networkingDataSource;

+ (XPModel *)sharedInstance
{
    static dispatch_once_t pred;
    static XPModel *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initConstants];
        
        [self initImageSizes];
        
        self.networkingDataSource = [MainNetworkingDataSource new];
    }
    
    return self;
}

- (void)initConstants
{    

}

- (void)initImageSizes
{
	float scale = [[UIScreen mainScreen] scale];
	CGSize size = [[UIScreen mainScreen] bounds].size;

	_twoColListImageWidth = size.width * .45 * scale;
	_oneColListImageWidth = size.width * .95 * scale;
	_smallListImageWidth = MAX(size.width * .25, 96) * scale;
	_detailImageWidth = size.width * scale;
	_logoImageWidth = MAX(size.width * .2, 96) * scale;
	_userImageWidth = 96 * scale;
	_userLimit = 5;
}

- (MainNetworkingDataSource *)mainNetworkingDataSource
{
    return self.networkingDataSource;
}


#pragma mark - Login Info

//- (void)saveLoginInfo:(id)loginInfo
//{
//	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//	NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:loginInfo];
//	[prefs setObject:myEncodedObject forKey:@"savedLoginInfo"];
//	[prefs synchronize];
//}
//
//- (id)getLoginInfo
//{
//	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//	NSData *myEncodedObject = [prefs objectForKey:@"savedLoginInfo"];
//	if (!myEncodedObject)
//		return nil;
//	id loginInfo = [NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
//	return loginInfo;
//}
//
//- (void)removeLoginInfo
//{
//	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//	[prefs removeObjectForKey:@"savedLoginInfo"];
//	[prefs synchronize];
//}

//#pragma mark - Location

//- (void)openDirectionsToCoordinate:(NSString *)destinationParameter
//{
//
//    NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?sspn=%@", destinationParameter];
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
//}

+ (UIViewController *)viewControllerWithIdentifier:(NSString *)viewControllerIdentifier fromStoryboardWithName:(NSString *)storyboardName
{
    UIViewController *viewControllerToReturn = nil;
    NSString *error = nil;
    
    if (!viewControllerIdentifier) {
        error = @"Nil view controller identifier";
    }
    
    if ([viewControllerIdentifier isEqualToString:@""]) {
        error = @"Empty view controller identifier";
    }
    
    if (!storyboardName) {
        error = @"Nil storyboard name";
    }
    
    if ([storyboardName isEqualToString:@""]) {
        error = @"Empty storyboard name";
    }
    
    if (error == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        viewControllerToReturn = [storyboard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
    }
    else
        NSLog(@"Encountered: %@", error);
    
    return viewControllerToReturn;
}

+ (void)openViewController:(UIViewController *)viewController inNavigationController:(UINavigationController *)navigationController
{
    if (viewController) {
        [navigationController pushViewController:viewController animated:YES];
    }
}


@end
