//
//  CustomTable.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTable.h"
#import "LevelPicker.h"
#import "Level.h"

#define kTITLE_HEIGHT 100

#define kTITLE_TAG 1989
#define kBUDDHA_TAG 1990

#define kNUM_LEVELS 9
#define kPADDING 10.0f

@implementation CustomTable

@synthesize m_pTitle, m_pLevelIDs, m_pBack, m_pPickers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        UIImageView* pBuddha = [[UIImageView alloc] initWithFrame: self.frame];
        pBuddha.image = [UIImage imageNamed:@"Buddha.jpg"];
        pBuddha.contentMode = UIViewContentModeScaleAspectFit;
        [pBuddha setUserInteractionEnabled: NO];
        [pBuddha setMultipleTouchEnabled: NO];
        pBuddha.tag = kBUDDHA_TAG;
        [self insertSubview:pBuddha atIndex:0];
        
        [self initTitle];
        [self initBackButton];
    }
    return self;
}   

- (void)initLevels
{
    DataManager* pDataManager = [DataManager sharedDataManager];
    m_pLevelIDs = [pDataManager getLevels];
    if ([m_pLevelIDs count] < 1) 
        return;
    
    m_pPickers = [[NSMutableArray alloc] initWithCapacity: [m_pLevelIDs count]];
    
    for (eGridPosition gridPos = egp_Top_Left; gridPos <= egp_Bot_Right; gridPos++) 
    {
        if (gridPos > ([m_pLevelIDs count] - 1)) 
            return;
        else
        {
            LevelPicker* pPicker = [[LevelPicker alloc] initWithFrame: [self gridForPosition: gridPos]];
            [m_pPickers addObject:pPicker];
            Level* pLevel = (Level*)[m_pLevelIDs objectAtIndex: gridPos];
            pPicker.m_pCT = self;
            [pPicker setLevelID: [pLevel a_Level_ID] withRating: [pLevel a_Rating]];
            [self addSubview: pPicker];
        }
    }
}

- (void) beginGameWithLevelID: (NSString*)pLevelID
{
    NSLog(@"CustomTable - beginGameWithLevelID");
    [[MyViewController getMVC] startGameWithLevelID: pLevelID];
    [self removeFromSuperview];
}

- (void) initBackButton
{
    m_pBack = [UIButton buttonWithType: UIButtonTypeCustom];
    m_pBack.frame = CGRectMake(0, 0, 100, 30);
    [m_pBack setTitle:@"Home" forState:UIControlStateNormal];
    [m_pBack.titleLabel setFont: [UIFont fontWithName:@"Arial-BoldMT" size:24]];
    [m_pBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_pBack addTarget:self action:@selector(quitGame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: m_pBack];
}

- (void) quitGame
{
    [[MyViewController getMVC] toMainMenu];
    [self removeFromSuperview];
}

- (CGRect) gridForPosition:(int)pos
{
    int nX = 0;
    int nY = 0;
    
    CGRect grid = [self getGridSpace];
    switch (pos) 
    {
        case egp_Top_Left:            
        {
            nX = grid.origin.x;
            nY = grid.origin.y;
            break;
        }
        case egp_Top_Center:            
        {
            nX = (grid.size.width / 3.0) + kPADDING;
            nY = grid.origin.y;
            break;
        }
        case egp_Top_Right:            
        {
            nX = ((grid.size.width / 3.0) * 2.0) + kPADDING;
            nY = grid.origin.y;
            break;
        }
        case egp_Mid_Left:            
        {
            nX = grid.origin.x;
            nY = grid.size.height / 2.0;
            break;
        }
        case egp_Mid_Center:            
        {
            nX = (grid.size.width / 3.0) + kPADDING;
            nY = grid.size.height / 2.0;
            break;
        }
        case egp_Mid_Right:            
        {
            nX = ((grid.size.width / 3.0) * 2.0) + kPADDING;
            nY = grid.size.height / 2.0;
            break;
        }
        case egp_Bot_Left:            
        {
            nX = grid.origin.x;
            nY = (grid.size.height / 3.0) * 2.5;
            break;
        }
        case egp_Bot_Center:            
        {
            nX = (grid.size.width / 3.0) + kPADDING;
            nY = (grid.size.height / 3.0) * 2.5;
            break;
        }
        case egp_Bot_Right:            
        {
            nX = ((grid.size.width / 3.0) * 2.0) + kPADDING;
            nY = (grid.size.height / 3.0) * 2.5;
            break;
        }
        default:
            NSLog(@"Bad position (%i) given to gridForPosition",pos);
            abort();
            break;
    }
    CGRect ret = CGRectMake(
                            nX, 
                            nY, 
                            grid.size.width / 3.0, 
                            grid.size.height / 3.0
                            );
    return ret;
}

- (void) initTitle
{
    int nFrameWidth = self.bounds.size.width;
    int nOriginX = self.bounds.origin.x;
    int nOriginY = self.bounds.origin.y;
    
    m_pTitle = [[UILabel alloc] initWithFrame:CGRectMake(
                                                         nOriginX, 
                                                         nOriginY, 
                                                         nFrameWidth, 
                                                         kTITLE_HEIGHT
                                                         )];
    m_pTitle.text = @"Pointless Jupiter - Level Selection";
    m_pTitle.backgroundColor = [UIColor clearColor];
    m_pTitle.textColor = [UIColor purpleColor];
    m_pTitle.shadowColor = [UIColor whiteColor];
    m_pTitle.shadowOffset = CGSizeMake(2, 2);
    m_pTitle.textAlignment = UITextAlignmentCenter;
    m_pTitle.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 50];
    [m_pTitle setTag: kTITLE_TAG];
    [m_pTitle setUserInteractionEnabled: NO];
    [m_pTitle setMultipleTouchEnabled: NO];
    
    [self addSubview: m_pTitle];
}


- (CGRect) getGridSpace
{
    int nOriginX = self.frame.origin.x;
    int nOriginY = self.frame.origin.y;
    int nFrameWidth = kLANDSCAPE_WIDTH;
    int nFrameHeight = kLANDSCAPE_HEIGHT;
//    NSLog(@"getGridSpace nFrameWidth = %i nFrameHeight = %i",nFrameWidth,nFrameHeight);
    
    CGRect gridSpace = CGRectMake(
                                  nOriginX + kPADDING, 
                                  nOriginY + kPADDING + kTITLE_HEIGHT, 
                                  nFrameWidth - kPADDING - (nOriginX + kPADDING), 
                                  nFrameHeight - kPADDING - (nOriginY + (kPADDING*2) + kTITLE_HEIGHT)
                                  );
//    NSLog(@"getGridSpace returning gridSpace = %@",NSStringFromCGRect(gridSpace));
    return gridSpace;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
