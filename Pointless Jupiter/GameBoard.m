//
//  GameBoard.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GameBoard.h"
#import "Accel.h"
#import "Wall.h"
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

- (void) initObjectWithTagID:(eImageTagID)eitid inLevel:(Level*)pLevel withData:(NSData*)pData
{
    NSKeyedUnarchiver* pUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:pData];
    NSDictionary* pDict = [pUnarchiver decodeObjectForKey:@"a_ImageAtts"];
    [pUnarchiver finishDecoding];
    CGRect bounds = CGRectFromString([pDict objectForKey:@"a_Bounds"]);
    CGPoint center = CGPointFromString([pDict objectForKey:@"a_Center"]);
    CGAffineTransform transform = CGAffineTransformFromString([pDict objectForKey:@"a_Transform"]);   
    switch (eitid) 
    {
        case eitid_Accel:
        case eitid_Trap:
        case eitid_Whirl:
        {
            BoardItem* pBA = [[BoardItem alloc] initWithItem: eitid inFrame:bounds];
            [pBA setCenter: center];
            pBA.transform = transform;
            [self addSubview: pBA];
            break;
        }
        case eitid_Wall:
        {
            Wall_Class* pWall = [[Wall_Class alloc] initWithFrame:bounds];
            [pWall setCenter: center];
            pWall.transform = transform;
            [self addSubview: pWall];
            break;
        }
        case eitid_Dest:
        {
            UIImageView* pDest = [[UIImageView alloc] initWithFrame:bounds];
            [pDest setImage: [UIImage imageNamed:@"Destination.jpg"]];
            [Pointless_JupiterAppDelegate roundImageCorners: pDest];
            [pDest setCenter: center];
            pDest.transform = transform;
            [self addSubview: pDest];
            break;
        }
        case eitid_Jupiter:
        {
            m_pJupiter = [[Jupiter alloc] initWithFrame:bounds];
            [m_pJupiter setCenter: center];
            m_pJupiter.transform = transform;
            [self addSubview: m_pJupiter];
            break;
        }
        default:
            break;
    }
}

- (void) initLevel:(Level*)pLevel
{
    NSData* pData = [pLevel.r_Ball valueForKey:@"a_ImageAtts"];
    [self initObjectWithTagID:eitid_Jupiter inLevel:pLevel withData:pData];
    pData = [pLevel.r_Dest valueForKey:@"a_ImageAtts"];
    [self initObjectWithTagID:eitid_Dest inLevel:pLevel withData:pData];
    
    NSArray* pAccels = [[pLevel r_Accels] allObjects];
    NSArray* pTraps = [[pLevel r_Traps] allObjects];
    NSArray* pWalls = [[pLevel r_Walls] allObjects];
    NSArray* pWhirls = [[pLevel r_Whirls] allObjects];
    
    for (int i = 0; i < [pAccels count]; i++) 
    {
        NSData* pData = [[pAccels objectAtIndex:i] a_ImageAtts];
        [self initObjectWithTagID:eitid_Accel inLevel:pLevel withData:pData];
    }
    for (int i = 0; i < [pTraps count]; i++) 
    {
        NSData* pData = [[pTraps objectAtIndex:i] a_ImageAtts];
        [self initObjectWithTagID:eitid_Trap inLevel:pLevel withData:pData];
    }
    for (int i = 0; i < [pWhirls count]; i++) 
    {
        NSData* pData = [[pWhirls objectAtIndex:i] a_ImageAtts];
        [self initObjectWithTagID:eitid_Whirl inLevel:pLevel withData:pData];
    }
    for (int i = 0; i < [pWalls count]; i++) 
    {
        NSData* pData = [[pWalls objectAtIndex:i] a_ImageAtts];
        [self initObjectWithTagID:eitid_Wall inLevel:pLevel withData:pData];
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


@end
