//
//  Ball.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Jupiter.h"

@interface Ball : NSManagedObject 
{
}
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) NSString * Rectangle;

// Get the game ball (Jupiter!) for a level
- (NSArray*) getBallforLevel:(NSString*)level error:(NSError*)pError;

// Set the game ball for a new level
- (void) setBall:(Jupiter*)pGameBall forLevel:(NSString*)level error:(NSError*)pError;

@end
