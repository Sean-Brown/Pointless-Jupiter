//
//  Walls.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Walls.h"
#import "Wall.h"

@implementation Walls
@dynamic Level_ID;
@dynamic Rectangle;

- (NSArray*) getWallsforLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Walls" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate =
    [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    
    NSArray *pWalls = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return pWalls;
}

- (void) setWalls:(NSArray*)pWalls forLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    for (Wall* wall in pWalls) 
    {
        NSManagedObject* pNewObject = 
        [NSEntityDescription insertNewObjectForEntityForName:@"Walls" inManagedObjectContext:pMoc];
        [pNewObject setValue:(id)&level forKey:@"LevelID"];
        CGRect frame = wall.frame;
        [pNewObject setValue:(id)&frame forKey:@"Rectangle"];
    }
    if (![pMoc save: &pError]) 
    {
        NSLog(@"Error saving walls");
    }
}

@end
