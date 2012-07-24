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
#import "Wall.h"
#import "Constants.h" 
#import "Util.h"

@implementation MyViewController

@synthesize m_pCurrentView, m_pLastAcceleration;

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
    m_pCurrentView = (UIView*)mv;
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


- (void) startNewGame
{
    // NSLog(@"Start New Game");
    
    // Initialize the new view w/ view controller
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    GameBoard* pGB = [[GameBoard alloc] initWithFrame: newFrame];
    pGB.m_pMyVC = self;
    
    // Add it as subview, remove old view
    [self.view insertSubview:(UIView*)pGB atIndex:0];
    NSUInteger i = [self.view.subviews count] - 1;
    while (i > 0)
        [[[self.view subviews] objectAtIndex: i--] removeFromSuperview];
    
    // Set the current view to the game board
    m_pCurrentView = pGB;
    [pGB release];
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
    
    // Add subview, remove old subviews
    [self.view insertSubview:(UIView*)pLB atIndex:0];
    NSUInteger i = [self.view.subviews count] - 1;
    while (i > 0)
        [[[self.view subviews] objectAtIndex: i--] removeFromSuperview];
    
    // Set the current view to the level builder
    m_pCurrentView = (UIView*)pLB;
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

@end
