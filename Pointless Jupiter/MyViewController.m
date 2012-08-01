//
//  MyViewController.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"
#import "MainView.h"
#import "GameBoard.h"
#import "BoardItem.h"
#import "LevelBuilder.h"
#import "Jupiter.h"
#import "Wall_Class.h"
#import "Constants.h" 
#import "DataManager.h"
#import "CustomTable.h"
#import "Util.h"

@implementation MyViewController

@synthesize m_pLastAcceleration;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - 
#pragma VIEW_LIFECYCLE

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    // NSLog(@"loadView from MyViewController");
    self.wantsFullScreenLayout = YES;
    
    m_pLastAcceleration = [[UIAcceleration alloc] init];
	CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    
	MainView* mv = [[MainView alloc] initWithFrame: newFrame];
    mv.m_pMyVC = self;
	self.view = mv;
    [mv release];
}

- (void)accelerometer:(UIAccelerometer* )accelerometer didAccelerate:(UIAcceleration* )acceleration {
    float prevX = m_pLastAcceleration.x;
    float prevY = m_pLastAcceleration.y;
    
    prevX = (float) acceleration.x*  FILTER_FACTOR + (1-FILTER_FACTOR)*  prevX;
    prevY = (float) acceleration.y*  FILTER_FACTOR + (1-FILTER_FACTOR)*  prevY;
    
    m_pLastAcceleration = acceleration;
}

- (void)calcNextPosition: fromAcceleration:(UIAcceleration*)acceleration
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) startGameWithLevelID:(NSString*)pLevelID
{
    NSLog(@"MyViewController - beginGameWithLevelID");
    NSArray* pLevel = [[DataManager getDataManager] getLevelWithID:pLevelID];
    
    if (pLevel == nil || [pLevel count] == 0) 
    {
        NSLog(@"Didn't retrieve any level with id %@", pLevelID);
        abort();
    }
    else
    {
        CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
        GameBoard* pGB = [[GameBoard alloc] initWithFrame: newFrame];
        pGB.m_pMyVC = self;
        [pGB initLevel: [pLevel objectAtIndex:0]];
        [self.view addSubview: (UIView*)pGB];
        
        [pGB release];
    }
}

- (void) startNewGame
{
    // NSLog(@"Start New Game");
    
    // Initialize the new view w/ view controller
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    CustomTable* pCT = [[CustomTable alloc] initWithFrame: newFrame];
    pCT.m_pMyVC = self;
    [pCT initLevels];
    [self.view addSubview: (UIView*)pCT];
}

- (void) viewHighScores
{
    // NSLog(@"View Best Times");
    // [currentView removeFromSuperview];
}

- (void) buildLevel
{
    // NSLog(@"Level Builder");
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    LevelBuilder* pLB = [[LevelBuilder alloc] initWithFrame:newFrame];
    pLB.m_pMyVC = self;
    
    [self.view addSubview: (UIView*)pLB];
    [pLB release];
}

- (void) setUserAccount
{
    // NSLog(@"Set User Account");
}

- (void) quitApp
{
    // NSLog(@"Quit App");
}

- (void) toMainMenu
{
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    MainView* mv = [[MainView alloc] initWithFrame: newFrame];
    mv.m_pMyVC = self;
    [self.view addSubview:(UIView*)mv];
    [mv release];
}

- (void) dealloc
{
    [super dealloc];
//    [m_pLastAcceleration dealloc];
}

@end
