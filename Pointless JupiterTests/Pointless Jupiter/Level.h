//
//  Level.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accelerators, Ball, Destinaton, Traps, Walls, Whirls;

@interface Level : NSManagedObject 
{
}
@property (nonatomic, retain) NSDate * Creation_Date;
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) Whirls * Whirls;
@property (nonatomic, retain) Destinaton * Destination;
@property (nonatomic, retain) Ball * Ball;
@property (nonatomic, retain) Walls * Walls;
@property (nonatomic, retain) Accelerators * Accelerators;
@property (nonatomic, retain) Traps * Traps;

// Getting levels
- (NSArray*)getLevels:(NSError*)pError;
- (NSArray*)getLevelWithID:(double)level error:(NSError*)pError;

// Saving levels
- (void)saveLevel:(double)level;

@end
