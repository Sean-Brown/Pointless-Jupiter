//
//  GameBoard.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jupiter.h"
#import "BoardItem.h"
#import "Wall_Class.h"
#import "MyViewController.h"
#import "DataManager.h"
#import "LevelPicker.h"

@interface GameBoard : UIView 
{
    MyViewController* m_pMyVC;
    
    Jupiter* m_pJupiter; // The game Jupiter
    
    UIButton* m_pStart;
    UIButton* m_pRestart;
    UIButton* m_pQuit;
}

@property (nonatomic, retain) Jupiter* m_pJupiter;

@property (nonatomic, retain) UIButton* m_pStart,* m_pRestart,* m_pQuit;

@property (nonatomic, assign) MyViewController* m_pMyVC;

- (void) initLevel:(Level*)pLevel;
- (void) initButtons;
- (void) startGame;
- (void) quitPlaying;
- (void) redraw:(int)levelID; // Redraw the board with the given id, usually in response to a Restart

-(BOOL) JupiterHitWall:(Point) JupiterPos; // Tells if the Jupiter hits a wall
-(double) calcNewTrajectory:(Wall_Class* ) wall: (Jupiter* ) Jupiter; // Calculates the Jupiter's new trajectory

@end
