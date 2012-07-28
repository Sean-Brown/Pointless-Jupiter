//
//  DataManager.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Level.h"

@interface DataManager : NSObject <NSFetchedResultsControllerDelegate>
{
@private
    NSFetchedResultsController* m_pFetchedResultsController;
    NSManagedObjectContext* m_pMOC;
}

@property (nonatomic, retain) NSManagedObjectContext* m_pMOC;
@property (nonatomic, retain) NSFetchedResultsController* m_pFetchedResultsController;

- (NSArray*) getLevels;
- (NSArray*) getLevel: withID:(NSString*)level;
- (void)saveLevel:(NSString*)level traps:(NSArray*)traps whirls:(NSArray*)whirls accels:(NSArray*)accels walls:(NSArray*)walls dests:(NSArray*)dests jupiter:(Jupiter*)jupiter rating:(NSNumber*)pRating;

- (NSArray*) getWallsforLevel:(NSString*)level;

- (NSArray*) getBallforLevel:(NSString*)level;
- (NSArray*) getDestinationforLevel:(NSString*)level;

- (NSArray*) getTrapsforLevel:(NSString*)level;
- (NSArray*) getAcceleratorsforLevel:(NSString*)level;
- (NSArray*) getWhirlsforLevel:(NSString*)level;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

+ (DataManager*) getDataManager;

@end
