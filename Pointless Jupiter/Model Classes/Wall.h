//
//  Wall.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Level;

@interface Wall : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * a_Bounds;
@property (nonatomic, retain) Level * r_Wall;

@end
