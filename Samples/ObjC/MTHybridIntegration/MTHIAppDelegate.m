//
//  MTHIAppDelegate.m
//  TSMobileTaggingIntegration
//
//  Copyright (c) 2016 TNS Sifo AB. All rights reserved.
//

#import "MTHIAppDelegate.h"
#import "MTHIViewController.h"
#import <TSMobileAnalytics/TSMobileAnalytics.h>

@interface MTHIAppDelegate () { }

@end

@implementation MTHIAppDelegate

@synthesize window = _winkdow;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController            = [[MTHIViewController alloc] initWithNibName:@"MTHIViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];

    [TSMobileAnalytics setLogPrintsActivated:YES];
    [TSMobileAnalytics initializeWithCPID:@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                          applicationName:@"Sample app"
                             trackingType:TrackUsersAndPanelists
           enableSystemIdentifierTracking:NO
                           isWebViewBased:YES
                      keychainAccessGroup:nil
                              additionals:nil];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of
    // temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use
    // this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application
    // state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate:
    // when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes
    // made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application
    // was previously in the background, optionally refresh the user interface.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also
    // applicationDidEnterBackground:.
}

#pragma mark -
#pragma openURL

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [TSMobileAnalytics application:application
                                  openURL:url
                                  options:options];
}

@end
