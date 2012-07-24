//
//  BestTimes.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BestTimes : NSManagedObject 
{
}
@property (nonatomic, retain) NSNumber * Time;
@property (nonatomic, retain) NSString * Level_ID;
@property (nonatomic, retain) NSString * Username;
@property (nonatomic, retain) NSManagedObject * User;

@end
