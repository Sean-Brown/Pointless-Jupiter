//
//  Whirl.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Level;

@interface Whirl : NSManagedObject {
@private
}
@property (nonatomic, strong) NSData * a_ImageAtts;
@property (nonatomic, strong) Level * r_Level;

@end
