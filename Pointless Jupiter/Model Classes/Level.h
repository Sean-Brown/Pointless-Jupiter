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
@property (nonatomic, strong) NSNumber * a_Rating;
@property (nonatomic, strong) NSDate * a_Creation_Date;
@property (nonatomic, strong) NSString * a_Level_ID;
@property (nonatomic, strong) NSString * a_CreatedBy;
@property (nonatomic, strong) NSSet* r_Walls;
@property (nonatomic, strong) NSSet* r_Accels;
@property (nonatomic, strong) NSSet* r_Traps;
@property (nonatomic, strong) Ball * r_Ball;
@property (nonatomic, strong) Dest * r_Dest;
@property (nonatomic, strong) NSSet* r_Whirls;
@property (nonatomic, strong) User * r_Creator;
@property (nonatomic, strong) BestTimes * r_Level;
@property (nonatomic, strong) NSSet* r_RatedBy;

@end
