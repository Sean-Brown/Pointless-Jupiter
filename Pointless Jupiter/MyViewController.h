//
//  MyViewController.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView, GameBoard, DataManager;

@interface MyViewController : UIViewController < UIAccelerometerDelegate > 
{
    UIAcceleration* m_pLastAcceleration;
}

@property (nonatomic, assign) UIAcceleration* m_pLastAcceleration;

- (void)calcNextPosition: fromAcceleration:(UIAcceleration*)acceleration;

- (void) startGameWithLevelID:(NSString*)pLevelID;
- (void) chooseLevel;
- (void) viewHighScores;
- (void) buildLevel;
- (void) setUserAccount;
- (void) quitApp;
- (void) toMainMenu;

@end
