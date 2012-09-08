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
@property (nonatomic, strong) NSString * a_Level_ID;
@property (nonatomic, strong) NSNumber * a_GlobalBest;
@property (nonatomic, strong) NSNumber * a_UserBest;
@property (nonatomic, strong) NSString * a_GlobalUser;
@property (nonatomic, strong) NSString * a_User;
@property (nonatomic, strong) Level * r_Level;
@property (nonatomic, strong) User * r_UserName;

@end
