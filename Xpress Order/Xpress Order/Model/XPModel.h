//
//  XP_Shared.h
//  XpressOrder
//
//  Created by Adrian Cucerzan on 1/08/14.
//

// import all model headers

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kFailedToChangePushSetting @"kFailedToChangePushSetting"
#define FinishedLoadingMerchantsNotification @"FinishedLoadingMerchantsNotification"

#if TARGET_IPHONE_SIMULATOR
    #define DUMMY @""
    #define myAppend(A,B) [(A) stringByAppendingString:(B)]
	#define getLang(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
	#define lang(key) myAppend(DUMMY, getLang(key))
#else
	#define lang(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
 #define lang(key) MyLocalizedString(key, @"")
#endif

#define MainStoryboardName @"Main"
#define ViewControllerWithIdentifier(a) [XPModel viewControllerWithIdentifier:a fromStoryboardWithName:MainStoryboardName]

#define OpenViewControllerInNavigation(vc, nav) [XPModel openViewController:vc inNavigationController:nav]

#import "MainNetworkingDataSource.h"
#import "Cafe.h"

typedef NS_ENUM(int, iPhoneScreenSize) {
	iPhoneScreenSize_iPhone4 = 0,
	iPhoneScreenSize_iPhone5 = 1,
	iPhoneScreenSize_iPhone6 = 2,
	iPhoneScreenSize_iPhone6Plus = 3
};

@interface XPModel : NSObject

@property (nonatomic, readonly) NSInteger twoColListImageWidth;
@property (nonatomic, readonly) NSInteger oneColListImageWidth;
@property (nonatomic, readonly) NSInteger smallListImageWidth;
@property (nonatomic, readonly) NSInteger detailImageWidth;
@property (nonatomic, readonly) NSInteger logoImageWidth;
@property (nonatomic, readonly) NSInteger userImageWidth;
@property (nonatomic, readonly) NSInteger userLimit;


#pragma mark Constructor

+ (XPModel *)sharedInstance;

#pragma mark - Model Data

@property (nonatomic) BOOL isInternetActive, isTranslucentNavigationBar;
@property (nonatomic) iPhoneScreenSize currentiPhoneScreenSize;

- (MainNetworkingDataSource *)mainNetworkingDataSource;

+ (UIViewController *)viewControllerWithIdentifier:(NSString *)viewControllerIdentifier fromStoryboardWithName:(NSString *)storyboardName;
+ (void)openViewController:(UIViewController *)viewController inNavigationController:(UINavigationController *)navigationController;

@end
