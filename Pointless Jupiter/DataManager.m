//
//  DataManager.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Pointless_JupiterAppDelegate.h"
#import "DataManager.h"
#import "Constants.h"

@implementation DataManager

@synthesize m_pMOC, m_pFetchedResultsController;

- (id) init
{
    if (self == [super init]) 
    {
    }
    return self;
}



#pragma mark -
#pragma mark LEVELS

- (NSArray*) getLevels
{
    if (m_pMOC == nil) 
    {
        Pointless_JupiterAppDelegate* pDelegate = [[UIApplication sharedApplication] delegate];
        
        self.m_pMOC = [pDelegate managedObjectContext];
    }
    
    NSEntityDescription *pEntityDescription = [NSEntityDescription entityForName:@"Level" inManagedObjectContext:m_pMOC];
    NSFetchRequest *pRequest = [[[NSFetchRequest alloc] init] autorelease];
    [pRequest setEntity:pEntityDescription];
    
    NSError* pError;
    NSArray* pLevels = [m_pMOC executeFetchRequest:pRequest error:&pError];
    if (pLevels == nil) 
        NSLog(@"No levels were retrieved from storage :-(");
    
    return pLevels;
}

- (NSArray*) getLevel: withID:(NSString*)level
{
    NSEntityDescription *pEntityDescription = [NSEntityDescription entityForName:@"Level" inManagedObjectContext:m_pMOC];
    NSFetchRequest *pRequest = [[[NSFetchRequest alloc] init] autorelease];
    [pRequest setEntity:pEntityDescription];
    NSPredicate* pPredicate = [NSPredicate predicateWithFormat:@"Level_ID == %@", level];
    [pRequest setPredicate: pPredicate];
    
    NSError* pError;
    NSArray *pLevels = [m_pMOC executeFetchRequest:pRequest error:&pError];
    if (pLevels == nil) 
        NSLog(@"Could not find the level with Level_ID = %@",level);

    return pLevels;
}

- (void)saveLevel:(NSString*)level traps:(NSArray*)traps whirls:(NSArray*)whirls accels:(NSArray*)accels walls:(NSArray*)walls dests:(NSArray*)dests jupiter:(Jupiter*)jupiter rating:(NSNumber*)pRating;
{   
    if (m_pMOC == nil) 
    {
        Pointless_JupiterAppDelegate* pDelegate = [[UIApplication sharedApplication] delegate];
        
        self.m_pMOC = [pDelegate managedObjectContext];
        [pDelegate release];
    }
	NSManagedObject* pNewLevel = [NSEntityDescription insertNewObjectForEntityForName:@"Level" inManagedObjectContext:m_pMOC];
    
    NSString* pBallString = NSStringFromCGRect(jupiter.frame);
    NSDate *pDate = [NSDate date];
    
    // Must have these four attributes
    [pNewLevel setValue:level forKey:@"Level_ID"];
    [pNewLevel setValue:pBallString forKey:@"Ball"];
    [pNewLevel setValue:pDate forKey:@"Creation_Date"];
    [pNewLevel setValue:dests forKey:@"Destination"];
    [pNewLevel setValue:pRating forKey:@"Rating"];
    
    // Optional attributes
    if ([traps count] != 0) 
        [pNewLevel setValue:traps forKey:@"Traps"];
    if ([whirls count] != 0) 
        [pNewLevel setValue:whirls forKey:@"Whirls"];
    if ([accels count] != 0) 
        [pNewLevel setValue:accels forKey:@"Accelerators"];
    if ([walls count] != 0) 
        [pNewLevel setValue:walls forKey:@"Walls"];
    
    NSError* pError;
    if (![m_pMOC save: &pError]) 
    {
        NSLog(@"Failed to save\n%@",[pError localizedDescription]);
        UIAlertView* pAlert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Map Unsucessfully Saved. Try Restarting The App." delegate:nil cancelButtonTitle:@"Return" otherButtonTitles:nil];
        pAlert.frame = CGRectMake(LANDSCAPE_WIDTH/3, LANDSCAPE_HEIGHT/3, LANDSCAPE_WIDTH/3, LANDSCAPE_HEIGHT/3);
        [pAlert show];
        [pAlert release];
    }
    else
    {
        NSLog(@"Successfully saved!");
        UIAlertView* pAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Map Successfully Saved!" delegate:nil cancelButtonTitle:@"Return" otherButtonTitles:nil];
        pAlert.frame = CGRectMake(LANDSCAPE_WIDTH/3, LANDSCAPE_HEIGHT/3, LANDSCAPE_WIDTH/3, LANDSCAPE_HEIGHT/3);
        [pAlert show];
        [pAlert release];
    }
}

#pragma mark -
#pragma mark WALLS

- (NSArray*) getWallsforLevel:(NSString*)level
{
    return nil;
}

#pragma mark -
#pragma mark BALL

- (NSArray*) getBallforLevel:(NSString*)level
{
    return nil;
}

#pragma mark -
#pragma mark DESTINATION

- (NSArray*) getDestinationforLevel:(NSString*)level
{
    return nil;
}

#pragma mark -
#pragma mark TRAPS

- (NSArray*) getTrapsforLevel:(NSString*)level
{
    return nil;
}

#pragma mark -
#pragma mark ACCELERATION

- (NSArray*) getAcceleratorsforLevel:(NSString*)level
{
    return nil;
}

#pragma mark -
#pragma mark WHIRLS

- (NSArray*) getWhirlsforLevel:(NSString*)level
{
    return nil;
}

#pragma mark -
#pragma mark CELL_CONFIGURATION

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    
    NSManagedObject* pMO = [self.m_pFetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[pMO valueForKey:@"Level_ID"] description];
}

+ (DataManager*)getDataManager
{
    static DataManager* pSharedDataManager;
    
    @synchronized(self)
    {
        if( !pSharedDataManager )
            pSharedDataManager = [[DataManager alloc] init];
        
        return pSharedDataManager;
    }
}

- (void) dealloc
{
    [super dealloc];
}

@end
