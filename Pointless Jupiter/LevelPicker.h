//
//  LevelPicker.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MyViewController.h"
#import "CustomTable.h"

@interface LevelPicker : UIView
{   
    CustomTable* m_pCT;
    
    NSString* m_pLevelID;
    
    UIImageView* m_pJupiter;
    UIImageView* m_pDest;
    
    NSNumber* m_pRating;
    
    bool bJupiterActive;
}

@property (nonatomic, assign) CustomTable* m_pCT;
@property (nonatomic, copy) NSString* m_pLevelID;
@property (nonatomic, retain) NSNumber* m_pRating;

- (void) setLevelID:(NSString*)levelID withRating:(NSNumber*)pRating;
- (void) makeLevelLabel:(NSString*)levelID;
- (void) initJupiterAndDest;
- (void) initRating:(NSNumber*)pRating;

@end
