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

#define TITLE_HEIGHT 100

#define TITLE_TAG 1989
#define BUDDHA_TAG 1990

#define NUM_LEVELS 9
#define PADDING 10.0f

@implementation CustomTable

@synthesize m_pTitle, m_pLevelIDs, m_pBack, m_pMyVC, m_pPickers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self respondsToSelector: @selector(startGameWithLevelID:)];
        // Initialization code
        UIImageView* pBuddha = [[UIImageView alloc] initWithFrame: self.frame];
        pBuddha.image = [UIImage imageNamed:@"Buddha.jpg"];
        pBuddha.contentMode = UIViewContentModeScaleAspectFit;
        [pBuddha setUserInteractionEnabled: NO];
        [pBuddha setMultipleTouchEnabled: NO];
        pBuddha.tag = BUDDHA_TAG;
        [self insertSubview:pBuddha atIndex:0];
        [pBuddha release];
        
        [self initTitle];
        [self initBackButton];
    }
    return self;
}

- (void)initLevels
{
    DataManager* pDataManager = [DataManager getDataManager];
    m_pLevelIDs = [pDataManager getLevels];
    if ([m_pLevelIDs count] < 1) 
        return;
    
    for (eGridPosition gridPos = eTOP_LEFT; gridPos <= eBOT_RIGHT; gridPos++) 
    {
        if (gridPos > ([m_pLevelIDs count] - 1)) 
            return;
        else
        {
            LevelPicker* pPicker = [[[LevelPicker alloc] initWithFrame: [self gridForPosition: gridPos]] autorelease];
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
    [m_pMyVC startGameWithLevelID: pLevelID];
    [self removeFromSuperview];
}

- (void) initBackButton
{
    m_pBack = [UIButton buttonWithType: UIButtonTypeCustom];
    m_pBack.frame = CGRectMake(
                               0, 
                               0, 
                               100, 
                               30);
    [m_pBack setTitle:@"Back" forState:UIControlStateNormal];
    [m_pBack.titleLabel setFont: [UIFont fontWithName:@"Arial-BoldMT" size:24]];
    [m_pBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_pBack addTarget:self action:@selector(quitGame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: m_pBack];
}

- (void) quitGame
{
    [m_pMyVC toMainMenu];
    [self removeFromSuperview];
}

- (CGRect) gridForPosition:(int)pos
{
    int nX = 0;
    int nY = 0;
    
    CGRect grid = [self getGridSpace];
    switch (pos) 
    {
        case eTOP_LEFT:            
        {
            nX = grid.origin.x;
            nY = grid.origin.y;
            break;
        }
        case eTOP_CENTER:            
        {
            nX = (grid.size.width / 3.0) + PADDING;
            nY = grid.origin.y;
            break;
        }
        case eTOP_RIGHT:            
        {
            nX = ((grid.size.width / 3.0) * 2.0) + PADDING;
            nY = grid.origin.y;
            break;
        }
        case eMID_LEFT:            
        {
            nX = grid.origin.x;
            nY = grid.size.height / 2.0;
            break;
        }
        case eMID_CENTER:            
        {
            nX = (grid.size.width / 3.0) + PADDING;
            nY = grid.size.height / 2.0;
            break;
        }
        case eMID_RIGHT:            
        {
            nX = ((grid.size.width / 3.0) * 2.0) + PADDING;
            nY = grid.size.height / 2.0;
            break;
        }
        case eBOT_LEFT:            
        {
            nX = grid.origin.x;
            nY = (grid.size.height / 3.0) * 2.5;
            break;
        }
        case eBOT_CENTER:            
        {
            nX = (grid.size.width / 3.0) + PADDING;
            nY = (grid.size.height / 3.0) * 2.5;
            break;
        }
        case eBOT_RIGHT:            
        {
            nX = ((grid.size.width / 3.0) * 2.0) + PADDING;
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
                                                         TITLE_HEIGHT
                                                         )];
    m_pTitle.text = @"Pointless Jupiter - Level Selection";
    m_pTitle.backgroundColor = [UIColor clearColor];
    m_pTitle.textColor = [UIColor purpleColor];
    m_pTitle.shadowColor = [UIColor whiteColor];
    m_pTitle.shadowOffset = CGSizeMake(2, 2);
    m_pTitle.textAlignment = UITextAlignmentCenter;
    m_pTitle.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 50];
    [m_pTitle setTag: TITLE_TAG];
    [m_pTitle setUserInteractionEnabled: NO];
    [m_pTitle setMultipleTouchEnabled: NO];
    
    [self addSubview: m_pTitle];
}


- (CGRect) getGridSpace
{
    int nOriginX = self.frame.origin.x;
    int nOriginY = self.frame.origin.y;
    int nFrameWidth = LANDSCAPE_WIDTH;
    int nFrameHeight = LANDSCAPE_HEIGHT;
//    NSLog(@"getGridSpace nFrameWidth = %i nFrameHeight = %i",nFrameWidth,nFrameHeight);
    
    CGRect gridSpace = CGRectMake(
                                  nOriginX + PADDING, 
                                  nOriginY + PADDING + TITLE_HEIGHT, 
                                  nFrameWidth - PADDING - (nOriginX + PADDING), 
                                  nFrameHeight - PADDING - (nOriginY + (PADDING*2) + TITLE_HEIGHT)
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

- (void)dealloc
{
    if (m_pLevelIDs != nil) 
        [m_pLevelIDs release];
    [m_pPickers release];
    [m_pTitle release];
    [m_pBack release];
    [super dealloc];
}

@end
