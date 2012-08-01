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
    MyViewController* m_pMyVC;
    
@private
    NSManagedObjectContext* m_pMOC;
    NSManagedObjectModel* m_pMOM;
    NSPersistentStoreCoordinator* m_pCoordinator;
}

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) MyViewController* m_pMyVC;

@property (nonatomic, retain, readonly) NSManagedObjectContext* m_pMOC;
@property (nonatomic, retain, readonly) NSManagedObjectModel* m_pMOM;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* m_pCoordinator;

void uncaughtExceptionHandler(NSException *exception);
-(void)saveContext;
- (NSManagedObjectContext*) managedObjectContext;
- (NSManagedObjectModel*) managedObjectModel;
- (NSPersistentStoreCoordinator*) persistentStoreCoordinator;
- (NSURL*)applicationDocumentsDirectory;
+ (void)roundImageCorners:(UIImageView*)pImage;

@end