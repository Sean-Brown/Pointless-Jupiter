//
//  CustomTable.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "MyViewController.h"

@interface CustomTable : UIView {
    MyViewController* m_pMyVC;
    
    NSArray* m_pLevelIDs;

    UILabel* m_pTitle;
    UIButton* m_pBack;
    
    int m_nCurrentIndex;
}

@property (nonatomic, assign) MyViewController* m_pMyVC;
@property (nonatomic, retain) NSArray* m_pLevelIDs;
@property (nonatomic, retain) NSMutableArray* m_pPickers;
@property (nonatomic, retain) UILabel* m_pTitle;
@property (nonatomic, retain) UIButton* m_pBack;

- (void) beginGameWithLevelID:(NSString*)pLevelID;
- (void) initLevels;
- (void) initTitle;
- (void) initBackButton;
- (void) quitGame;
- (CGRect) gridForPosition:(int)pos;
- (CGRect) getGridSpace;

@end
