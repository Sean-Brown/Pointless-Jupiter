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

- (void)archiveAttsForObject:(NSManagedObject*)pObject withDictionary:(NSDictionary*)pDictionary optionalItem:(id)pItem;

- (NSArray*) getLevels;
- (NSArray*) getLevelWithID:(NSString*)level;
- (void)saveLevel:(NSString*)level traps:(NSMutableArray*)traps whirls:(NSMutableArray*)whirls accels:(NSMutableArray*)accels walls:(NSMutableArray*)walls dest:(NSDictionary*)dest jupiter:(NSDictionary*)jupiter rating:(NSNumber*)pRating;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

+ (DataManager*) getDataManager;

@end
