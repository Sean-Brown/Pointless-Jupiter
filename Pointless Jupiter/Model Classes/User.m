//
//  User.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "BestTimes.h"
#import "Level.h"


@implementation User
@dynamic a_Name;
@dynamic a_Password;
@dynamic r_Creator;
@dynamic r_BestTime;
@dynamic r_LevelRated;

- (void)addCreatorObject:(Level *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Creator" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Creator"] addObject:value];
    [self didChangeValueForKey:@"Creator" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeCreatorObject:(Level *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Creator" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Creator"] removeObject:value];
    [self didChangeValueForKey:@"Creator" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addCreator:(NSSet *)value 
{    
    [self willChangeValueForKey:@"Creator" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Creator"] unionSet:value];
    [self didChangeValueForKey:@"Creator" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeCreator:(NSSet *)value 
{
    [self willChangeValueForKey:@"Creator" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Creator"] minusSet:value];
    [self didChangeValueForKey:@"Creator" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addBestTimeObject:(BestTimes *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"BestTime"] addObject:value];
    [self didChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeBestTimeObject:(BestTimes *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"BestTime"] removeObject:value];
    [self didChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addBestTime:(NSSet *)value 
{    
    [self willChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"BestTime"] unionSet:value];
    [self didChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeBestTime:(NSSet *)value 
{
    [self willChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"BestTime"] minusSet:value];
    [self didChangeValueForKey:@"BestTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addLevelRatedObject:(Level *)value 
{    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"LevelRated"] addObject:value];
    [self didChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeLevelRatedObject:(Level *)value 
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"LevelRated"] removeObject:value];
    [self didChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addLevelRated:(NSSet *)value 
{    
    [self willChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"LevelRated"] unionSet:value];
    [self didChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeLevelRated:(NSSet *)value 
{
    [self willChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"LevelRated"] minusSet:value];
    [self didChangeValueForKey:@"LevelRated" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
