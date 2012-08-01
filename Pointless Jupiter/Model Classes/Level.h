//
//  Level.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BestTimes;
@class Ball;
@class Dest;
@class User;

@interface Level : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * a_Rating;
@property (nonatomic, retain) NSDate * a_Creation_Date;
@property (nonatomic, retain) NSString * a_Level_ID;
@property (nonatomic, retain) NSString * a_CreatedBy;
@property (nonatomic, retain) NSSet* r_Walls;
@property (nonatomic, retain) NSSet* r_Accels;
@property (nonatomic, retain) NSSet* r_Traps;
@property (nonatomic, retain) Ball * r_Ball;
@property (nonatomic, retain) Dest * r_Dest;
@property (nonatomic, retain) NSSet* r_Whirls;
@property (nonatomic, retain) User * r_Creator;
@property (nonatomic, retain) BestTimes * r_Level;
@property (nonatomic, retain) NSSet* r_RatedBy;

@end
