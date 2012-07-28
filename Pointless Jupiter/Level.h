//
//  Level.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Jupiter.h"

@interface Level : NSManagedObject 
{
}
@property (nonatomic, retain) NSDate * Creation_Date;
@property (nonatomic, retain) NSString * Level_ID;
@property (nonatomic, retain) NSNumber * Rating;
@property (nonatomic, retain) NSArray * Accelerators;
@property (nonatomic, assign) NSString * Ball;
@property (nonatomic, retain) NSArray * Dests;
@property (nonatomic, retain) NSArray * Traps;
@property (nonatomic, retain) NSArray * Whirls;
@property (nonatomic, retain) NSArray * Walls;

@end
