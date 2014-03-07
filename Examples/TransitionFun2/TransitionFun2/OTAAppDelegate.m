//
//  OTAAppDelegate.m
//  TransitionFun2
//
//  Created by Ari Braginsky on 3/6/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "OTAAppDelegate.h"

#import "ECSlidingViewController.h"
#import "MEZoomAnimationController.h"

#import "OTACenterViewController.h"
#import "OTALeftViewController.h"

@interface OTAAppDelegate ()
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@property (nonatomic, strong) MEZoomAnimationController *transition;
@end

@implementation OTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	
	self.window.rootViewController = [self loadHamburgerMenu];
	[self.window makeKeyAndVisible];
	
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController *) loadHamburgerMenu {

	UIViewController *topViewController = [[OTACenterViewController alloc] initWithNibName: @"OTACenterViewController" bundle: nil];
    UIViewController *underLeftViewController = [[OTALeftViewController alloc] initWithNibName: @"OTALeftViewController" bundle: nil];

	// main nav
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];

    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:navigationController];
    self.slidingViewController.underLeftViewController = underLeftViewController;
    self.slidingViewController.underRightViewController = nil;
	
    // configure anchored layout
	// (leaving out anchorRight or anchorLeft causes its value to be calculated dynamically)
	self.slidingViewController.anchorRightPeekAmount = 50.0;

	// custom zoom transition setup (borrowing MEZoomAnimationController)
	self.transition = [[MEZoomAnimationController alloc] init];
	self.slidingViewController.delegate = self.transition;

	// enable swiping on the top view, including navigation bar
	[navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
	
	// allow tapping on current top view to bring it back into focus
	self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
	
	return self.slidingViewController;
}

@end
