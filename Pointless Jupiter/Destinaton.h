//
//  Destinaton.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Destinaton : NSManagedObject 
{
}
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) NSString * Rectangle;

// Get Destinations
- (NSArray*) getDestinationforLevel:(NSString*)level error:(NSError*)pError;

// Set Destinations for a new level
- (void) setDestinations:(NSArray*)pDests forLevel:(NSString*)level error:(NSError*)pError;

@end
