//
//  Pointless_JupiterAppDelegate.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Pointless_JupiterAppDelegate.h"

@implementation Pointless_JupiterAppDelegate


@synthesize window, m_pMyVC, m_pMOC, m_pMOM, m_pCoordinator;

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
    
    [self saveContext];
}

- (void)saveContext
{
    NSError* pError = nil;
	NSManagedObjectContext* pMOC = [self managedObjectContext];
    if (pMOC != nil) 
    {
        if ([pMOC hasChanges] && ![pMOC save:&pError]) 
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", pError, [pError userInfo]);
            abort();
        } 
    }
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext*) managedObjectContext 
{
    
    if (m_pMOC != nil) 
    {
        return m_pMOC;
    }
    
    NSPersistentStoreCoordinator *pCoordinator = [self persistentStoreCoordinator];
    if (pCoordinator != nil) 
    {
        m_pMOC = [[NSManagedObjectContext alloc] init];
        [m_pMOC setPersistentStoreCoordinator:pCoordinator];
    }
    return m_pMOC;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel*)managedObjectModel 
{
    
    if (m_pMOM != nil) 
    {
        return m_pMOM;
    }
    else
    {
        m_pMOM = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSAssert(m_pMOM != nil, @"Unable to find yo damn model, fool");
    
        return m_pMOM;
    }
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator 
{
    
    if (m_pCoordinator != nil) 
    {
        return m_pCoordinator;
    }
    
    NSURL *pStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Level.momd"];
    
    NSError *pError = nil;
    m_pCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![m_pCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:pStoreURL options:nil error:&pError]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:pStoreURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        
        NSLog(@"Unresolved error %@, %@", pError, [pError userInfo]);
        abort();
    }    
    
    return m_pCoordinator;
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL*)applicationDocumentsDirectory 
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)dealloc
{
    [m_pMOC release];
    [m_pMOM release];
    [m_pCoordinator release];
    
    [window release];
    [m_pMyVC release];
    [super dealloc];
}

// Only round square images
+ (void)roundImageCorners:(UIImageView*)pImageView
{
    float fRadius = pImageView.layer.frame.size.width/2.0;
    pImageView.layer.cornerRadius = fRadius;
    pImageView.layer.masksToBounds = YES;
    pImageView.layer.borderColor = [UIColor blackColor].CGColor;
    pImageView.layer.borderWidth = 1.0;
}

@end
