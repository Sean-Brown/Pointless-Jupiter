//
//  MyViewController.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView, GameBoard;

@interface MyViewController : UIViewController < UIAccelerometerDelegate > 
{
    UIView* m_pCurrentView;
    UIAcceleration* m_pLastAcceleration;
}

@property (nonatomic, assign) UIView* m_pCurrentView;
@property (nonatomic, assign) UIAcceleration* m_pLastAcceleration;

- (void)calcNextPosition: fromAcceleration:(UIAcceleration*)acceleration;

- (void) startNewGame;
- (void) viewHighScores;
- (void) buildLevel;
- (void) setUserAccount;
- (void) quitApp;

@end
