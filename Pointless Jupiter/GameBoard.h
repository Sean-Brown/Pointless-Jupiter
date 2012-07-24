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

@interface GameBoard : UIView 
{
    MyViewController* m_pMyVC;
    
    int m_iLevelId; 
    NSString* m_pstUser;
    
    Jupiter* m_pJupiter; // The game Jupiter
    NSArray* m_pObstacles; // Array of board objects
    NSArray* m_pWalls; // Array of walls
    
    UIImageView* m_pJupiterImg;
    
    UIButton* m_pbtStart;
    UIButton* m_pbtRestart;
    UIButton* m_pbtQuit;
}

@property (nonatomic, retain) Jupiter* m_pJupiter;
@property (nonatomic, retain) NSArray* m_pObstacles;
@property (nonatomic, retain) NSArray* m_pWalls;

@property (nonatomic, copy) NSString* m_pstrUser;
@property (nonatomic, retain) UIButton* m_pbtStart,* m_pbtRestart,* m_pbtQuit;

@property (nonatomic, assign) MyViewController* m_pMyVC;

- (void) redraw:(int)levelID; // Redraw the board with the given id, usually in response to a Restart

-(BOOL) JupiterHitWall:(Point) JupiterPos; // Tells if the Jupiter hits a wall
-(double) calcNewTrajectory:(Wall* ) wall: (Jupiter* ) Jupiter; // Calculates the Jupiter's new trajectory

@end
