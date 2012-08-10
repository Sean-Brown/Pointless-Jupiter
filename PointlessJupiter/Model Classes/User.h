//
//  User.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BestTimes, Level;

@interface User : NSManagedObject {
@private
}
@property (nonatomic, strong) NSString * a_Name;
@property (nonatomic, strong) NSString * a_Password;
@property (nonatomic, strong) NSSet* r_Creator;
@property (nonatomic, strong) NSSet* r_BestTime;
@property (nonatomic, strong) NSSet* r_LevelRated;

@end
