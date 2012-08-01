//
//  Level.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level.h"
#import "BestTimes.h"


@implementation Level
@dynamic a_Rating;
@dynamic a_Creation_Date;
@dynamic a_Level_ID;
@dynamic a_CreatedBy;
@dynamic r_Walls;
@dynamic r_Accels;
@dynamic r_Traps;
@dynamic r_Ball;
@dynamic r_Dest;
@dynamic r_Whirls;
@dynamic r_Creator;
@dynamic r_Level;
@dynamic r_RatedBy;



- (void)addWallObject:(NSManagedObject *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Wall" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Wall"] addObject:value];
    [self didChangeValueForKey:@"Wall" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWallObject:(NSManagedObject *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Wall" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Wall"] removeObject:value];
    [self didChangeValueForKey:@"Wall" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWall:(NSSet *)value 
{    
    [self willChangeValueForKey:@"Wall" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Wall"] unionSet:value];
    [self didChangeValueForKey:@"Wall" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWall:(NSSet *)value 
{
    [self willChangeValueForKey:@"Wall" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Wall"] minusSet:value];
    [self didChangeValueForKey:@"Wall" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addAccelObject:(NSManagedObject *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Accel" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Accel"] addObject:value];
    [self didChangeValueForKey:@"Accel" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeAccelObject:(NSManagedObject *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Accel" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Accel"] removeObject:value];
    [self didChangeValueForKey:@"Accel" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addAccel:(NSSet *)value 
{    
    [self willChangeValueForKey:@"Accel" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Accel"] unionSet:value];
    [self didChangeValueForKey:@"Accel" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeAccel:(NSSet *)value 
{
    [self willChangeValueForKey:@"Accel" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Accel"] minusSet:value];
    [self didChangeValueForKey:@"Accel" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addTrapObject:(NSManagedObject *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Trap" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Trap"] addObject:value];
    [self didChangeValueForKey:@"Trap" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeTrapObject:(NSManagedObject *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Trap" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Trap"] removeObject:value];
    [self didChangeValueForKey:@"Trap" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addTrap:(NSSet *)value 
{    
    [self willChangeValueForKey:@"Trap" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Trap"] unionSet:value];
    [self didChangeValueForKey:@"Trap" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeTrap:(NSSet *)value 
{
    [self willChangeValueForKey:@"Trap" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Trap"] minusSet:value];
    [self didChangeValueForKey:@"Trap" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}




- (void)addWhirlObject:(NSManagedObject *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Whirl"] addObject:value];
    [self didChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWhirlObject:(NSManagedObject *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Whirl"] removeObject:value];
    [self didChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWhirl:(NSSet *)value 
{    
    [self willChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Whirl"] unionSet:value];
    [self didChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWhirl:(NSSet *)value 
{
    [self willChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Whirl"] minusSet:value];
    [self didChangeValueForKey:@"Whirl" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}




- (void)addRatedByObject:(NSManagedObject *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"RatedBy"] addObject:value];
    [self didChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeRatedByObject:(NSManagedObject *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"RatedBy"] removeObject:value];
    [self didChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addRatedBy:(NSSet *)value 
{    
    [self willChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"RatedBy"] unionSet:value];
    [self didChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeRatedBy:(NSSet *)value 
{
    [self willChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"RatedBy"] minusSet:value];
    [self didChangeValueForKey:@"RatedBy" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
