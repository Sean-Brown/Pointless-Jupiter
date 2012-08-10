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
    
	CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    
	MainView* mv = [[MainView alloc] initWithFrame: newFrame];
	self.view = mv;
}

- (void)accelerometer:(UIAccelerometer* )accelerometer didAccelerate:(UIAcceleration* )acceleration
{
    
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
        UIAlertView* pAlert = [[UIAlertView alloc] initWithTitle:@"Internal Error" message:@"The level could not be loaded. Try a different level or try restarting the app/your iPad." delegate:nil cancelButtonTitle:@"Return" otherButtonTitles:nil];
        pAlert.frame = CGRectMake(
                                  kLANDSCAPE_WIDTH / 3, 
                                  kLANDSCAPE_HEIGHT / 3,
                                  kLANDSCAPE_WIDTH / 3, 
                                  kLANDSCAPE_HEIGHT / 3 
                                  );
        [pAlert show];
        return;
    }
    else
    {
        CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
        GameBoard* pGB = [[GameBoard alloc] initWithFrame: newFrame];
        [pGB initLevel: [pLevel objectAtIndex:0]];
        [self.view addSubview: (UIView*)pGB];
    }
}

- (void) chooseLevel
{
    [MyViewController removeAllSubviews];
    // Initialize the new view w/ view controller
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    CustomTable* pCT = [[CustomTable alloc] initWithFrame: newFrame];
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
    [MyViewController removeAllSubviews];  
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    LevelBuilder* pLB = [[LevelBuilder alloc] initWithFrame:newFrame];
    [self.view addSubview: (UIView*)pLB];
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
    [MyViewController removeAllSubviews];
    CGRect newFrame = makeScreen([UIScreen mainScreen].applicationFrame);
    MainView* mv = [[MainView alloc] initWithFrame: newFrame];
    [self.view addSubview:(UIView*)mv];
}

+ (void)removeAllSubviews
{
    for (UIView* pSubviews in [MyViewController getMVC].view.subviews)
    {
        [pSubviews removeFromSuperview];
    }
}

+ (MyViewController*)getMVC
{
    static MyViewController* pSharedMVC;
    
    @synchronized(self)
    {
        if( !pSharedMVC )
            pSharedMVC = [[MyViewController alloc] init];
        
        return pSharedMVC;
    }
}


@end
