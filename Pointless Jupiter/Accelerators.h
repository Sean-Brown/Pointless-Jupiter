//
//  Accelerators.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Accelerators : NSManagedObject 
{
}
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) NSString * Rectangle;

// Get the accelerators for a level
- (NSArray*) getAcceleratorsforLevel:(NSString*)level error:(NSError*)pError;

// Set the accelerators for a new level
- (void) setAccelerators:(NSArray*)pAccels forLevel:(NSString*)level error:(NSError*)pError;

@end
