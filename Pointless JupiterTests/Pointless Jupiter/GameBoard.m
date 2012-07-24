//
//  GameBoard.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "GameBoard.h"

#define MAX_ITEMS 32 // Maximum items the obstacles array can contain

@implementation GameBoard

@synthesize m_pJupiter, m_pObstacles, m_pWalls, m_pstrUser, m_pMyVC, m_pbtStart, m_pbtRestart, m_pbtQuit; // accelerometer;

- (id) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) 
    {
        NSLog(@"Initializing GameBoard");
        self.backgroundColor = [UIColor whiteColor];
        // For testing purposes, put down a Jupiter
        m_pJupiter = [[UIImageView alloc] initWithFrame: CGRectMake(200, 200, 50, 50)];

        [self addSubview: m_pJupiter];
    }
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [m_pJupiter dealloc];
    [m_pJupiter dealloc];
    [m_pObstacles dealloc];
    [m_pWalls dealloc];
    [m_pMyVC dealloc];
    [m_pstrUser dealloc];
    [m_pbtStart dealloc];
    [m_pbtRestart dealloc];
    [m_pbtQuit dealloc];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"GameBoard is starting to rotate");
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
    NSLog(@"GameBoard has finished rotating");
}

- (void) redraw:(int)levelID
{
    
}

-(BOOL) JupiterHitWall:(Point) JupiterPos
{
    BOOL hitWall = false;
    
    return hitWall;
}

-(double) calcNewTrajectory:(Wall* ) wall: (Jupiter* ) Jupiter
{
    double newTraj = 0.0;
    
    return newTraj;
}

@end
