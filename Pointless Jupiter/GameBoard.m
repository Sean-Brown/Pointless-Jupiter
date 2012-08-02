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
#import "Accel.h"
#import "Pointless_JupiterAppDelegate.h"

#define kMAX_ITEMS 32 // Maximum items the obstacles array can contain

@implementation GameBoard

@synthesize m_pJupiter, m_pStart, m_pRestart, m_pQuit;

- (id) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) 
    {
//        NSLog(@"Initializing GameBoard with frame = %@", NSStringFromCGRect(frame));
        UIImageView* pBackground = [[UIImageView alloc] initWithFrame: frame];
        pBackground.image = [UIImage imageNamed:@"Night.jpg"];
        [self addSubview:pBackground];
        [pBackground release];
        
        m_pStart = [[UIButton alloc] init];
        m_pRestart = [[UIButton alloc] init];
        m_pQuit = [[UIButton alloc] init];
        [self initButtons];
    }
    
    return self;
}

- (void)initButtons
{
    m_pStart = [UIButton buttonWithType: UIButtonTypeCustom];
    m_pStart.frame = CGRectMake(
                                kLANDSCAPE_WIDTH - 100, 
                                0, 
                                100, 
                                30
                                );
    [m_pStart setTitle:@"Start" forState:UIControlStateNormal];
    [m_pStart setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [m_pStart addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    m_pQuit = [UIButton buttonWithType: UIButtonTypeCustom];
    m_pQuit.frame = CGRectMake(
                               kLANDSCAPE_WIDTH - 100, 
                               30, 
                               100, 
                               30
                               );
    [m_pQuit setTitle:@"Quit" forState:UIControlStateNormal];
    [m_pQuit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_pQuit addTarget:self action:@selector(quitPlaying) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: m_pStart];
    [self addSubview: m_pQuit];
}

- (void) initLevel:(Level*)pLevel
{
    NSString* pJupiter = [[pLevel valueForKey:@"r_Ball"] valueForKey:@"a_Frame"];
    NSString* pDest = [[pLevel valueForKey:@"r_Dest"] valueForKey:@"a_Frame"];
    
    NSArray* pAccels = [[pLevel r_Accels] allObjects];
    NSArray* pTraps = [[pLevel r_Traps] allObjects];
    NSArray* pWalls = [[pLevel r_Walls] allObjects];
    NSArray* pWhirls = [[pLevel r_Whirls] allObjects];
    
    UIImageView* dest = [[UIImageView alloc] initWithFrame: CGRectFromString(pDest)];
    dest.image = [UIImage imageNamed: @"Destination.jpg"];
    [Pointless_JupiterAppDelegate roundImageCorners: dest];
    [self addSubview: dest];
    [dest release];
    
    m_pJupiter = [[Jupiter alloc] initWithFrame: CGRectFromString(pJupiter)];
    [self addSubview: m_pJupiter];
    
    for (int i = 0; i < [pAccels count]; i++) 
    {
        NSString* pFrame = [[pAccels objectAtIndex:i] a_Frame];
        BoardItem* pAccel = [[[BoardItem alloc] initWithItem:emi_Accel inFrame: CGRectFromString(pFrame)] autorelease];
        [self addSubview: pAccel];
    }
    for (int i = 0; i < [pTraps count]; i++) 
    {
        NSString* pFrame = [[pTraps objectAtIndex:i] a_Frame];
        BoardItem* pTrap = [[[BoardItem alloc] initWithItem:emi_Trap inFrame: CGRectFromString(pFrame)] autorelease];
        [self addSubview: pTrap];
    }
    for (int i = 0; i < [pWhirls count]; i++) 
    {
        NSString* pFrame = [[pWhirls objectAtIndex:i] a_Frame];
        BoardItem* pWhirl = [[[BoardItem alloc] initWithItem:emi_Whirl inFrame: CGRectFromString(pFrame)] autorelease];
        [self addSubview: pWhirl];
    }
    for (int i = 0; i < [pWalls count]; i++) 
    {
        NSString* pFrame = [[pWalls objectAtIndex:i] a_Frame];
        Wall_Class* pWall = [[[Wall_Class alloc] initWithFrame: CGRectFromString(pFrame)] autorelease];
        [self addSubview: pWall];
    }
}

- (void) startGame
{
    
}

- (void) quitPlaying
{
    [[MyViewController getMVC] toMainMenu];
    [self removeFromSuperview];
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

- (BOOL) JupiterHitWall:(Point) JupiterPos
{
    BOOL hitWall = false;
    
    return hitWall;
}

- (double) calcNewTrajectory:(Wall_Class* ) wall: (Jupiter* ) Jupiter
{
    double newTraj = 0.0;
    
    return newTraj;
}

- (void) dealloc
{
    [m_pJupiter release];
    [m_pStart release];     
    [m_pRestart release];
    [m_pQuit release];
    [super dealloc];
}

@end
