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

@synthesize m_pstrUser, m_pbtNewGame, m_pbtSetUser, m_pbtLevelBuilder, m_pbtBestTimes;

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

+ (id) initButton: (UIButton*)button atY:(int)yCoord withTitle: (NSString*)title withColor: (UIColor*)color inView:(UIView*)pView
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
    [pView addSubview: button];
    return button;
}

- (id) initWithFrame:(CGRect)frame
{
//    NSLog(@"Initializing the MainView with frame %@",NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) 
    {
        UIImageView* pBackground = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Night.png"]];
        [self addSubview: pBackground];
        
        UILabel* pointless = [[UILabel alloc] init];
        [self initLabel: pointless withName: @"Pointless" atY:(CGFloat)100];
        UILabel* jupi = [[UILabel alloc] init];
        [self initLabel: jupi withName: @"Jupiter" atY:(CGFloat)500];
        [self addSubview: pointless];
        [self addSubview: jupi];
        
        UIImageView* jupiter = [[UIImageView alloc] initWithFrame: CGRectMake(150, 200, 300, 300)];
        UIImage* img = [UIImage imageNamed:@"Jupiter.png"];
        jupiter.image = img;
        [self addSubview: jupiter];
        
        float height = kLANDSCAPE_HEIGHT/6.0;
        m_pbtNewGame = [MainView initButton: m_pbtNewGame atY:height withTitle:@"New Game" withColor:[UIColor greenColor] inView:self];
        m_pbtBestTimes = [MainView initButton: m_pbtBestTimes atY:height*2 withTitle:@"Best Times" withColor:[UIColor redColor] inView:self];
        m_pbtLevelBuilder = [MainView initButton: m_pbtLevelBuilder atY:height*3 withTitle:@"Level Builder" withColor:[UIColor cyanColor] inView:self];
        m_pbtSetUser = [MainView initButton: m_pbtSetUser atY:height*4 withTitle:@"My Account" withColor:[UIColor orangeColor] inView:self];
        
        // Add press event handlers
        [m_pbtNewGame addTarget:[MyViewController getMVC] action:@selector(chooseLevel) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtBestTimes addTarget:[MyViewController getMVC] action:@selector(viewHighScores) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtLevelBuilder addTarget:[MyViewController getMVC] action:@selector(buildLevel) forControlEvents:UIControlEventTouchUpInside];
        [m_pbtSetUser addTarget:[MyViewController getMVC] action:@selector(setUserAccount) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
