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
#import "Pointless_JupiterAppDelegate.h"

#define MAX_ITEMS 32 // Maximum items the obstacles array can contain

@implementation GameBoard

@synthesize m_pJupiter, m_pObstacles, m_pWalls, m_pstrUser, m_pMyVC, m_pStart, m_pRestart, m_pQuit, m_pstrLevelID;

- (id) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) 
    {
//        NSLog(@"Initializing GameBoard with frame = %@", NSStringFromCGRect(frame));
        UIImageView* pBackground = [[UIImageView alloc] initWithFrame: frame];
        pBackground.image = [UIImage imageNamed:@"Night.jpg"];
        [self addSubview:pBackground];
        [pBackground release];
        
        UILabel* pLabel = [[UILabel alloc] initWithFrame: CGRectMake(
                                                                     0, 
                                                                     0, 
                                                                     LANDSCAPE_WIDTH, 
                                                                     LANDSCAPE_HEIGHT/6
                                                                     )];
        [self initLabel: pLabel];
        [self addSubview: pLabel];
        [pLabel release];
        
        m_pStart = [[UIButton alloc] init];
        m_pRestart = [[UIButton alloc] init];
        m_pQuit = [[UIButton alloc] init];
        [self initButtons];
    }
    
    return self;
}

- (void) initLabel: (UILabel*)label
{
    label.text = @"Pointless Jupiter";
    label.textColor = [UIColor purpleColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(2, 2);
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 72];
    label.backgroundColor = [UIColor clearColor];
}

- (void)initButtons
{
    m_pStart = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    m_pStart.frame = CGRectMake(
                                LANDSCAPE_WIDTH - 100, 
                                LANDSCAPE_HEIGHT - 100, 
                                100, 
                                30
                                );
    [m_pStart setTitle:@"Start" forState:UIControlStateNormal];
    [m_pStart setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [m_pStart addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    m_pQuit = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    m_pQuit.frame = CGRectMake(
                               LANDSCAPE_WIDTH - 100, 
                               LANDSCAPE_HEIGHT - 50, 
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
    NSString* pJupiter = [[pLevel valueForKey:@"r_Ball"] valueForKey:@"a_Bounds"];
    NSString* pDest = [[pLevel valueForKey:@"r_Dest"] valueForKey:@"a_Bounds"];
    
    NSArray* pAccels = [pLevel valueForKey:@"Accelerators"];
    NSArray* pTraps = [pLevel valueForKey:@"Traps"];
    NSArray* pWalls = [pLevel valueForKey:@"Walls"];
    NSArray* pWhirls = [pLevel valueForKey:@"Whirls"];
    
    UIImageView* dest = [[UIImageView alloc] initWithFrame: CGRectFromString(pDest)];
    dest.image = [UIImage imageNamed: @"Destination.jpg"];
    [Pointless_JupiterAppDelegate roundImageCorners: dest];
    [self addSubview: dest];
    [dest release];
    
    UIImageView* jupiter = [[UIImageView alloc] initWithFrame: CGRectFromString(pJupiter)];
    jupiter.image = [UIImage imageNamed:@"Jupiter.jpg"];
    [Pointless_JupiterAppDelegate roundImageCorners: jupiter];
    [self addSubview: jupiter];
    [jupiter release];
    
    for (int i = 0; i < [pAccels count]; i++) 
    {
        BoardItem* object = [pAccels objectAtIndex:i];
        BoardItem* accel = [[BoardItem alloc] initWithItem:eAccelItem inFrame: object.frame];
        [self addSubview: accel];
        [self addSubview: object];
    }
    for (int i = 0; i < [pTraps count]; i++) 
    {
        BoardItem* trap = [pTraps objectAtIndex:i];
        [trap setTag: eTrapItem];
        [self addSubview: trap];
    }
    for (int i = 0; i < [pAccels count]; i++) 
    {
        Wall_Class* wall = [pWalls objectAtIndex:i];
        [self addSubview: wall];
    }
    for (int i = 0; i < [pAccels count]; i++) 
    {
        BoardItem* whirl = [pWhirls objectAtIndex:i];
        [whirl setTag: eWhirlItem];
        [self addSubview: whirl];
    }
}

- (void) quitPlaying
{
    [m_pMyVC toMainMenu];
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

-(BOOL) JupiterHitWall:(Point) JupiterPos
{
    BOOL hitWall = false;
    
    return hitWall;
}

-(double) calcNewTrajectory:(Wall_Class* ) wall: (Jupiter* ) Jupiter
{
    double newTraj = 0.0;
    
    return newTraj;
}

- (void) dealloc
{
    [m_pJupiter release];
    [m_pObstacles release];
    [m_pWalls release];
    [m_pstrUser release];
    [m_pStart release];
    [m_pRestart release];
    [m_pQuit release];
    [super dealloc];
}

@end
