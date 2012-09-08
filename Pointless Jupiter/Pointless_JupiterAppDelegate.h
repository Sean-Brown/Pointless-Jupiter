//
//  Pointless_JupiterAppDelegate.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "MyViewController.h"

@interface Pointless_JupiterAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow* window;  
@private
    NSManagedObjectContext* m_pMOC;
    NSManagedObjectModel* m_pMOM;
    NSPersistentStoreCoordinator* m_pCoordinator;
}

@property (nonatomic, strong) UIWindow* window;

@property (nonatomic, strong, readonly) NSManagedObjectContext* m_pMOC;
@property (nonatomic, strong, readonly) NSManagedObjectModel* m_pMOM;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator* m_pCoordinator;

void uncaughtExceptionHandler(NSException *exception);
-(void)saveContext;
- (NSManagedObjectContext*) managedObjectContext;
- (NSManagedObjectModel*) managedObjectModel;
- (NSPersistentStoreCoordinator*) persistentStoreCoordinator;
- (NSURL*)applicationDocumentsDirectory;

@end
