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

@interface CustomTable : UIView
{
    NSArray* m_pLevelIDs;
    NSMutableArray* m_pPickers;
    
    UILabel* m_pTitle;
    UIButton* m_pBack;
    
    int m_nCurrentIndex;
}

@property (nonatomic, strong) NSArray* m_pLevelIDs;
@property (nonatomic, strong) NSMutableArray* m_pPickers;
@property (nonatomic, strong) UILabel* m_pTitle;
@property (nonatomic, strong) UIButton* m_pBack;

- (void) beginGameWithLevelID:(NSString*)pLevelID;
- (void) initLevels;
- (void) initTitle;
- (void) initBackButton;
- (void) quitGame;
- (CGRect) gridForPosition:(int)pos;
- (CGRect) getGridSpace;

@end
