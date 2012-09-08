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
#import "Constants.h"

@interface GameBoard : UIView 
{
    Jupiter* m_pJupiter; // The game Jupiter
    
    NSDate* m_pStartTime; // The time will be given by the current time minus the start time
    UILabel* m_pTimeLabel;
    NSTimer* m_pTimer;
    
    UIButton* m_pStart;
    UIButton* m_pRestart;
    UIButton* m_pQuit;
}

@property (nonatomic, strong) Jupiter* m_pJupiter;
@property (nonatomic, strong) NSDate* m_pStartTime;
@property (nonatomic, strong) UIButton* m_pStart,* m_pRestart,* m_pQuit;

- (void) initObjectWithTagID:(eImageTagID)eitid inLevel:(Level*)pLevel withData:(NSData*)pData;
- (void) initLevel:(Level*)pLevel;
- (void) initButtons;
- (void) initLabel;
- (void) startGame;
- (void) quitPlaying;
- (void) redraw:(int)levelID; // Redraw the board with the given id, usually in response to a Restart

-(BOOL) JupiterHitWall:(Point) JupiterPos; // Tells if the Jupiter hits a wall
-(double) calcNewTrajectory:(Wall_Class* ) wall: (Jupiter* ) Jupiter; // Calculates the Jupiter's new trajectory

@end
