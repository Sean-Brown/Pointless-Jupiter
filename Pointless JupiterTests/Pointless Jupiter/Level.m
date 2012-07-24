//
//  Level.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level.h"
#import "Accelerators.h"
#import "Ball.h"
#import "Destinaton.h"
#import "Traps.h"
#import "Walls.h"
#import "Whirls.h"


@implementation Level
@dynamic Creation_Date;
@dynamic Level_ID;
@dynamic Whirls;
@dynamic Destination;
@dynamic Ball;
@dynamic Walls;
@dynamic Accelerators;
@dynamic Traps;

- (NSArray*)getLevels:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Level" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    
    NSArray *levels = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return levels;
}

- (NSArray*)getLevelWithID:(double)level error:(NSError*)pError;
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Levels" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate =
    [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    NSArray* pLevel = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return pLevel;
}

- (void)saveLevel:(double)level;
{
    
}

@end
