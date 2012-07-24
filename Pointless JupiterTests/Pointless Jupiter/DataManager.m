//
//  DataManager.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DataManager.h"
#import "Constants.h"

@implementation DataManager

@synthesize m_pAccel, m_pBall, m_pDestination, m_pLevel, m_pTraps, m_pWalls, m_pWhirls, m_pError;

- (id) init
{
    if (self == [super init]) 
    {
        m_pError = [[NSError alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark LEVELS

- (NSArray*) getLevels
{
    return [m_pLevel getLevels: m_pError];
}

- (NSArray*) getLevel: withID:(double)level
{
    return [m_pLevel getLevelWithID: level error:m_pError];
}

#pragma mark -
#pragma mark WALLS

- (NSArray*) getWallsforLevel:(NSString*)level
{
    return [m_pWalls getWallsforLevel:level error:m_pError];
}

#pragma mark -
#pragma mark BALL

- (NSArray*) getBallforLevel:(NSString*)level
{
    return [m_pBall getBallforLevel:level error:m_pError];
}

#pragma mark -
#pragma mark DESTINATION

- (NSArray*) getDestinationforLevel:(NSString*)level
{
    return [m_pDestination getDestinationforLevel:level error:m_pError];
}

#pragma mark -
#pragma mark TRAPS

- (NSArray*) getTrapsforLevel:(NSString*)level
{
    return [m_pTraps getTrapsforLevel:level error:m_pError];
}

#pragma mark -
#pragma mark ACCELERATION

- (NSArray*) getAcceleratorsforLevel:(NSString*)level
{
    return [m_pAccel getAcceleratorsforLevel:level error:m_pError];
}

#pragma mark -
#pragma mark WHIRLS

- (NSArray*) getWhirlsforLevel:(NSString*)level
{
    return [m_pWhirls getWhirlsforLevel:level error:m_pError];
}

- (void) dealloc
{
    [super dealloc];
    [m_pError dealloc];
}

@end
