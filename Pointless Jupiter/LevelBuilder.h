//
//  LevelBuilder.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "Jupiter.h"
#import "BoardItem.h"
#import "Wall_Class.h"
#import "DataManager.h"

@interface LevelBuilder : UIView <UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    NSMutableArray* m_pItems;
    
    UIButton* m_pWallImg;
    UIButton* m_pTrap;
    UIButton* m_pAccel;
    UIButton* m_pWhirl;
    UIButton* m_pJupi;
    UIButton* m_pDest;
    UIButton* m_pRemove;
    
    UIButton* m_pSave;
    UIButton* m_pQuit;
    
    UIImageView* m_pSelectedItemImage;
    
    UITextField* m_pLevelID;
    
    int m_nDestCount;
    int m_nJupiCount;
    
    bool m_bRotating;
    bool m_bPinching;
}

@property (nonatomic, strong) NSMutableArray* m_pItems;

@property (nonatomic, strong) UIButton* m_pWallImg, * m_pTrap, * m_pAccel,* m_pWhirl,* m_pJupi,* m_pRemove,* m_pDest,* m_pSave,* m_pQuit;

@property (nonatomic, strong) UIImageView* m_pSelectedItemImage;

@property (nonatomic, strong) UITextField* m_pLevelID;

- (void)initImages:(id)sender;
- (void)initSaveQuit;
- (void)initGestures;
- (void)processPinch:(id)sender;
- (void)processRotate:(id)sender;
- (void)removeItem:(id)sender;
- (void)snapToGrid;
- (void)checkOverlap;
- (void)saveLevelWithID:(NSString*)level;
- (void)saveLevel;
- (void)quitLevelBuilder;

// UITextFieldDelegate protocol
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

@end
