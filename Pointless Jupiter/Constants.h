//
//  Constants.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#pragma mark -
#pragma mark PHYSICS

#define kFILTER_FACTOR 0.05f

#pragma mark -
#pragma mark ITEM_GEOMETRY

#define kLANDSCAPE_WIDTH 1024.0f
#define kLANDSCAPE_HEIGHT 768.0f
#define kLANDSCAPE_KEYBOARD_HEIGHT 264.0f
#define kLANDSCAPE_SCREEN CGRectMake(0,0,1024,768)

#define kGAME_WIDTH 860.0f
#define kGAME_HEIGHT 750.0f

#pragma mark -
#pragma mark - LEVEL_BUILDER


typedef enum 
{
    eitid_Wall,
    eitid_Trap,
    eitid_Accel,
    eitid_Whirl,
    eitid_Jupiter,
    eitid_Dest,
    eitid_Remove
}eImageTagID;

#pragma mark -
#pragma mark TIMER

#define kSTEP_INTERVAL 1/60.0f

#pragma mark -
#pragma mark LEVEL_SELECTION

typedef enum
{
    egp_Top_Left = 0,
    egp_Top_Center = 1,
    egp_Top_Right = 2,
    egp_Mid_Left = 3,
    egp_Mid_Center = 4,
    egp_Mid_Right = 5,
    egp_Bot_Left = 6,
    egp_Bot_Center = 7,
    egp_Bot_Right = 8
}eGridPosition;

#pragma mark -
#pragma mark ERROR_CODES

typedef enum
{
    eec_Level_Exists = 100
}eErrorCodes;

#pragma mark -
#pragma mark OTHER

static NSMutableDictionary* newItemDictionary()
{
    return [[NSMutableDictionary alloc] 
            initWithObjects: [NSArray arrayWithObjects:@"", @"", @"", nil] 
            forKeys: [NSArray arrayWithObjects:@"a_Bounds",@"a_Center", @"a_Transform", nil]];
};

#define kMIN_RATING -32768
#define kMAX_RATIN 32767
