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
#import "Wall.h"
#import "MyViewController.h"
#import "DataManager.h"
#import "LevelPicker.h"
#import "MyTableViewController.h"

@interface GameBoard : UIView 
{
    MyTableViewController* m_pMyTVC;
    MyViewController* m_pMyVC;
    
    NSString* m_pstrLevelID; 
    NSString* m_pstUser;
    
    Jupiter* m_pJupiter; // The game Jupiter
    NSArray* m_pObstacles; // Array of board objects
    NSArray* m_pWalls; // Array of walls
    
    UIImageView* m_pJupiterImg;
    
    UIButton* m_pStart;
    UIButton* m_pRestart;
    UIButton* m_pQuit;
}

@property (nonatomic, retain) Jupiter* m_pJupiter;
@property (nonatomic, retain) NSArray* m_pObstacles;
@property (nonatomic, retain) NSArray* m_pWalls;

@property (nonatomic, assign) NSString* m_pstrLevelID;
@property (nonatomic, copy) NSString* m_pstrUser;
@property (nonatomic, retain) UIButton* m_pStart,* m_pRestart,* m_pQuit;

@property (nonatomic, assign) MyViewController* m_pMyVC;

- (void) initLabel:(UILabel*)pLabel;
- (void) initButtons;
- (void) quitPlaying;
- (void) redraw:(int)levelID; // Redraw the board with the given id, usually in response to a Restart

-(BOOL) JupiterHitWall:(Point) JupiterPos; // Tells if the Jupiter hits a wall
-(double) calcNewTrajectory:(Wall* ) wall: (Jupiter* ) Jupiter; // Calculates the Jupiter's new trajectory

@end
