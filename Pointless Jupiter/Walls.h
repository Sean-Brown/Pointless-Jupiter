//
//  Walls.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Walls : NSManagedObject {

}
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) NSString * Rectangle;

// Get walls for a level
- (NSArray*) getWallsforLevel:(NSString*)level error:(NSError*)pError;

// Set walls for a new level
- (void) setWalls:(NSArray*)pWalls forLevel:(NSString*)level error:(NSError*)pError;

@end
