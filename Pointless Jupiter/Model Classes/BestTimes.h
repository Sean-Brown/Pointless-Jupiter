//
//  BestTimes.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Level, User;

@interface BestTimes : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * a_Level_ID;
@property (nonatomic, retain) NSNumber * a_GlobalBest;
@property (nonatomic, retain) NSNumber * a_UserBest;
@property (nonatomic, retain) NSString * a_GlobalUser;
@property (nonatomic, retain) NSString * a_User;
@property (nonatomic, retain) Level * r_Level;
@property (nonatomic, retain) User * r_UserName;

@end
