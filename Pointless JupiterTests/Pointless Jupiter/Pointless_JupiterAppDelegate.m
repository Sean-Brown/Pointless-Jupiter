//
//  Pointless_JupiterAppDelegate.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Pointless_JupiterAppDelegate.h"

@implementation Pointless_JupiterAppDelegate


@synthesize window, m_pMyVC;

// Credit to Zane Claes - http://stackoverflow.com/questions/7841610/xcode-4-2-debug-doesnt-symbolicate-stack-call
void uncaughtExceptionHandler(NSException *exception) 
{
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

- (BOOL)application:(UIApplication* )application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    NSLog(@"app did finish launching with options");
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    MyViewController* viewController = [[MyViewController alloc] init];
    self.m_pMyVC = viewController;
    [viewController release];
    
	m_pMyVC.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[m_pMyVC view]];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication* )application
{
    NSLog(@"app will resign active");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    */
}

- (void)applicationDidEnterBackground:(UIApplication* )application
{
    NSLog(@"app did enter background");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    */
}

- (void)applicationWillEnterForeground:(UIApplication* )application
{
    NSLog(@"app will enter foreground");
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    */
}

- (void)applicationDidBecomeActive:(UIApplication* )application
{
    NSLog(@"app did become active");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    */
}

- (void)applicationWillTerminate:(UIApplication* )application
{
    NSLog(@"app will terminate");
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
    */
}

- (void)dealloc
{
    [window dealloc];
    [m_pMyVC dealloc];
    [super dealloc];
}

@end
