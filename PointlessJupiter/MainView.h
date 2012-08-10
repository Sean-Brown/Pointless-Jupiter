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
    NSString* m_pstrUser;
    
    UIButton* m_pbtNewGame,* m_pbtBestTimes,* m_pbtLevelBuilder,* m_pbtSetUser;
}

@property (nonatomic, copy) NSString* m_pstrUser;

@property (nonatomic, strong) UIButton* m_pbtNewGame,* m_pbtBestTimes,* m_pbtLevelBuilder,* m_pbtSetUser;

- (void) initLabel: (UILabel*)label withName: (NSString*)name atY: (CGFloat)yCoord;
- (void) addButton: (UIButton*)button atY:(int)yCoord withTitle: (NSString*)title withColor: (UIColor*)color;

@end
