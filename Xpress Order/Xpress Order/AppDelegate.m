//
//  AppDelegate.m
//  Xpress Order
//
//  Created by Adrian Cucerzan on 02/11/15.
//  Copyright © 2015 Adrian Cucerzan. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
//    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
//    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
//    splitViewController.delegate = self;
    
    [XPModel sharedInstance];
    
    iPhoneScreenSize iPhoneScreenSize = iPhoneScreenSize_iPhone4;
    
    float windowSize = self.window.frame.size.height;
    
#define TOTAL_NUMBER_OF_IPHONE_SIZES 4
    
    int iPhoneSizes[TOTAL_NUMBER_OF_IPHONE_SIZES] = { iPhoneScreenSize_iPhone4, iPhoneScreenSize_iPhone5, iPhoneScreenSize_iPhone6, iPhoneScreenSize_iPhone6Plus };
    float sizes[TOTAL_NUMBER_OF_IPHONE_SIZES] = { 480, 568, 667, 736 };
    
    for (int i = 0; i < TOTAL_NUMBER_OF_IPHONE_SIZES; i++)
        if (windowSize == sizes[i])
            iPhoneScreenSize = iPhoneSizes[i];
    
    [[XPModel sharedInstance] setCurrentiPhoneScreenSize:iPhoneScreenSize];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
