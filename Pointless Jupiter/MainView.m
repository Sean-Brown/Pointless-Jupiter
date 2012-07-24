//
//  MainView.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainView.h"
#import "Constants.h"

@implementation MainView

@synthesize m_pMyVC, m_pstrUser, m_pbtNewGame, m_pbtSetUser, m_pbtLevelBuilder, m_pbtBestTimes, m_pbtQuit;

- (void) initLabel: (UILabel*)label withName: (NSString*)name atY: (CGFloat)yCoord
{
    label.text = name;
    label.textColor = [UIColor purpleColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"AppleGothic" size: 64];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(150, yCoord, 300, 100);
}

- (id) initButton: (UIButton*)button atY:(int)yCoord withTitle: (NSString*)title withColor: (UIColor*)color
{
    button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    button.frame = CGRectMake(666, yCoord, 150, 40);
    button.layer.cornerRadius = 12.0;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 3.0;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor: color forState: UIControlStateNormal];
    [button setTitleShadowColor: [UIColor yellowColor] forState:UIControlStateNormal];
    [button setTitle:title forState: UIControlStateNormal];
    [self addSubview: button];
    return button;
}

- (id) initWithFrame:(CGRect)frame
{
    // NSLog(@"Initializing the MainView");
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setBackgroundColor: [UIColor blackColor]];
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
        [self addSubview: jupiter];
        [jupiter release];
        [img release];
        
        m_pbtNewGame = [self initButton: m_pbtNewGame atY:100 withTitle:@"New Game" withColor: [UIColor greenColor]];
        m_pbtBestTimes = [self initButton: m_pbtBestTimes atY:200 withTitle:@"Best Times" withColor: [UIColor blueColor]];
        m_pbtLevelBuilder = [self initButton: m_pbtLevelBuilder atY:300 withTitle:@"Level Builder" withColor: [UIColor orangeColor]];
        m_pbtSetUser = [self initButton: m_pbtSetUser atY:400 withTitle:@"My Account" withColor: [UIColor cyanColor]];
        m_pbtQuit = [self initButton: m_pbtQuit atY:500 withTitle:@"Quit" withColor: [UIColor redColor]];
        
        // Add press event handlers
        [m_pbtNewGame addTarget:m_pMyVC action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtBestTimes addTarget:m_pMyVC action:@selector(viewHighScores) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtLevelBuilder addTarget:m_pMyVC action:@selector(buildLevel) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtSetUser addTarget:m_pMyVC action:@selector(setUserAccount) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtQuit addTarget:m_pMyVC action:@selector(quitApp) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    // NSLog(@"Dealloc'ing MainView");
    m_pMyVC = nil;
    [m_pMyVC dealloc];
    
    [m_pbtQuit dealloc];
    [m_pbtSetUser dealloc];
    [m_pbtBestTimes dealloc];
    [m_pbtLevelBuilder dealloc];
    [m_pbtNewGame dealloc];
    [super dealloc];
}

@end
