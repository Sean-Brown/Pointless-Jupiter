//
//  Whirls.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Whirls : NSManagedObject 
{
}
@property (nonatomic, retain) NSNumber * Level_ID;
@property (nonatomic, retain) NSString * Rectangle;

// Getting whirls for a level
- (NSArray*) getWhirlsforLevel:(NSString*)level error:(NSError*)pError;

// Setting whirls for a new level
- (void) setWalls:(NSArray*)pWhirls forLevel:(NSString*)level error:(NSError*)pError;

@end
