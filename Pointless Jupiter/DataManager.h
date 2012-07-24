//
//  DataManager.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Accelerators.h"
#import "Ball.h"
#import "Destinaton.h"
#import "Level.h"
#import "Traps.h"
#import "Walls.h"
#import "Whirls.h"

@interface DataManager : NSObject 
{
    NSError* m_pError;
    
    Accelerators* m_pAccel;
    Ball* m_pBall;
    Destinaton* m_pDestination;
    Level* m_pLevel;
    Traps* m_pTraps;
    Walls* m_pWalls;
    Whirls* m_pWhirls;
}

@property (nonatomic, retain) NSError* m_pError;

@property (nonatomic, retain) Accelerators* m_pAccel;
@property (nonatomic, retain) Ball* m_pBall;
@property (nonatomic, retain) Destinaton* m_pDestination;
@property (nonatomic, retain) Level* m_pLevel;
@property (nonatomic, retain) Traps* m_pTraps;
@property (nonatomic, retain) Walls* m_pWalls;
@property (nonatomic, retain) Whirls* m_pWhirls;

- (NSArray*) getLevels;
- (NSArray*) getLevel: withID:(double)level;

- (NSArray*) getWallsforLevel:(NSString*)level;

- (NSArray*) getBallforLevel:(NSString*)level;
- (NSArray*) getDestinationforLevel:(NSString*)level;

- (NSArray*) getTrapsforLevel:(NSString*)level;
- (NSArray*) getAcceleratorsforLevel:(NSString*)level;
- (NSArray*) getWhirlsforLevel:(NSString*)level;

@end
