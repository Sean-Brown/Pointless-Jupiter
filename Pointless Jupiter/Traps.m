//
//  Traps.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Traps.h"
#import "BoardItem.h"

@implementation Traps
@dynamic Level_ID;
@dynamic Rectangle;

- (NSArray*) getTrapsforLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Accelerators" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate =
    [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    
    NSArray *pTraps = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return pTraps;
}

- (void) setTraps:(NSArray*)pTraps forLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    for (BoardItem* trap in pTraps) 
    {
        NSManagedObject* pNewObject = 
        [NSEntityDescription insertNewObjectForEntityForName:@"Traps" inManagedObjectContext:pMoc];
        [pNewObject setValue:(id)&level forKey:@"LevelID"];
        CGRect frame = trap.frame;
        [pNewObject setValue:(id)&frame forKey:@"Rectangle"];
    }
    if (![pMoc save: &pError]) 
    {
        NSLog(@"Error saving traps");
    }
}

@end
