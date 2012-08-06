//
//  Ball.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Level;

@interface Ball : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * a_Frame;
@property (nonatomic, retain) Level * r_Level;

@end
