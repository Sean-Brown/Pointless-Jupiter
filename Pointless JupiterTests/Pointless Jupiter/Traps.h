//
//  Traps.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Traps : NSManagedObject 
{
}
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) NSString * Rectangle;

// Get traps for a level
- (NSArray*) getTrapsforLevel:(NSString*)level error:(NSError*)pError;

// Set traps for a new level
- (void) setTraps:(NSArray*)pTraps forLevel:(NSString*)level error:(NSError*)pError;

@end
