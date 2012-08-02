//
//  MainView.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainView.h"
#import "Pointless_JupiterAppDelegate.h"
#import "Constants.h"

@implementation MainView

@synthesize m_pMyVC, m_pstrUser, m_pbtNewGame, m_pbtSetUser, m_pbtLevelBuilder, m_pbtBestTimes;

- (void) initLabel: (UILabel*)label withName: (NSString*)name atY: (CGFloat)yCoord
{
    label.text = name;
    label.textColor = [UIColor purpleColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(2, 2);
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 72];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(150, yCoord, 300, 100);
}

- (id) initButton: (UIButton*)button atY:(int)yCoord withTitle: (NSString*)title withColor: (UIColor*)color
{
    button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(666, yCoord, 300, 50);
    button.layer.cornerRadius = 12.0;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 3.0;
    [button setBackgroundColor: [UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor: color forState: UIControlStateNormal];
    [[button titleLabel] setFont: [UIFont fontWithName:@"Arial-BoldMT" size:36]];
    [[button titleLabel] setShadowOffset: CGSizeMake(1,1)];
    [[button titleLabel] setShadowColor: [UIColor yellowColor]];
    [self addSubview: button];
    return button;
}

- (id) initWithFrame:(CGRect)frame
{
//    NSLog(@"Initializing the MainView with frame %@",NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) 
    {
        UIImageView* pBackground = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Night.jpg"]];
        [self addSubview: pBackground];
        [pBackground release];
        
        UILabel* pointless = [[UILabel alloc] init];
        [self initLabel: pointless withName: @"Pointless" atY:(CGFloat)100];
        UILabel* jupi = [[UILabel alloc] init];
        [self initLabel: jupi withName: @"Jupiter" atY:(CGFloat)500];
        [self addSubview: pointless];
        [self addSubview: jupi];
        [pointless release];
        [jupi release];
        
        UIImageView* jupiter = [[UIImageView alloc] initWithFrame: CGRectMake(150, 200, 300, 300)];
        UIImage* img = [UIImage imageNamed:@"Jupiter.jpg"];
        jupiter.image = img;
        [Pointless_JupiterAppDelegate roundImageCorners: jupiter];
        [self addSubview: jupiter];
        [jupiter release];
        [img release];
        
        float height = kLANDSCAPE_HEIGHT/6.0;
        m_pbtNewGame = [self initButton: m_pbtNewGame atY:height withTitle:@"New Game" withColor: [UIColor greenColor]];
        m_pbtBestTimes = [self initButton: m_pbtBestTimes atY:height*2 withTitle:@"Best Times" withColor: [UIColor redColor]];
        m_pbtLevelBuilder = [self initButton: m_pbtLevelBuilder atY:height*3 withTitle:@"Level Builder" withColor: [UIColor cyanColor]];
        m_pbtSetUser = [self initButton: m_pbtSetUser atY:height*4 withTitle:@"My Account" withColor: [UIColor orangeColor]];
        
        // Add press event handlers
        [m_pbtNewGame addTarget:m_pMyVC action:@selector(chooseLevel) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtBestTimes addTarget:m_pMyVC action:@selector(viewHighScores) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtLevelBuilder addTarget:m_pMyVC action:@selector(buildLevel) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtSetUser addTarget:m_pMyVC action:@selector(setUserAccount) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)dealloc
{
    // NSLog(@"Dealloc'ing MainView");
    if (m_pbtNewGame)
        [m_pbtSetUser release];
    if (m_pbtBestTimes)
        [m_pbtBestTimes release];
    if (m_pbtLevelBuilder)
        [m_pbtLevelBuilder release];
    [super dealloc];
}

@end
