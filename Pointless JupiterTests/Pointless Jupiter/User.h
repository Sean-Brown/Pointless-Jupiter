//
//  User.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BestTimes;

@interface User : NSManagedObject 
{
}
@property (nonatomic, retain) NSString * Password;
@property (nonatomic, retain) NSString * Username;
@property (nonatomic, retain) NSString * DeviceID;
@property (nonatomic, retain) BestTimes * FastestTimes;

@end
