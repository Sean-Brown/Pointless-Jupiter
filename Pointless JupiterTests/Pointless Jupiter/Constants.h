//
//  Constants.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#pragma mark -
#pragma PHYSICS

#define FILTER_FACTOR 0.05f

#pragma mark -
#pragma ITEM_GEOMETRY

#define LANDSCAPE_WIDTH 1024.0f
#define LANDSCAPE_HEIGHT 768.0f
#define LANDSCAPE_KEYBOARD_HEIGHT 264.0f

#define GAME_WIDTH 860.0f
#define GAME_HEIGHT 750.0f

#pragma mark -
#pragma TIMER

#define STEP_INTERVAL 1/60.0f

#pragma mark -
#pragma ERROR_CODES
typedef enum
{
    LEVEL_EXISTS = 100
}error_codes;