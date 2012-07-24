//
//  MainView.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"

@interface MainView : UIView 
{
    MyViewController* m_pMyVC;
    
    NSString* m_pstrUser;
    
    UIButton* m_pbtNewGame,* m_pbtBestTimes,* m_pbtLevelBuilder,* m_pbtSetUser,* m_pbtQuit;
}

@property (nonatomic, assign) MyViewController* m_pMyVC;

@property (nonatomic, copy) NSString* m_pstrUser;

@property (nonatomic, assign) UIButton* m_pbtNewGame,* m_pbtBestTimes,* m_pbtLevelBuilder,* m_pbtSetUser,* m_pbtQuit;

- (void) initLabel: (UILabel*)label withName: (NSString*)name atY: (CGFloat)yCoord;
- (id) initButton: (UIButton*)button atY:(int)yCoord withTitle: (NSString*)title withColor: (UIColor*)color;

@end
