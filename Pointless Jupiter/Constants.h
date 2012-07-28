//
//  Constants.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#pragma mark -
#pragma mark PHYSICS

#define FILTER_FACTOR 0.05f

#pragma mark -
#pragma mark ITEM_GEOMETRY

#define LANDSCAPE_WIDTH 1024.0f
#define LANDSCAPE_HEIGHT 768.0f
#define LANDSCAPE_KEYBOARD_HEIGHT 264.0f

#define GAME_WIDTH 860.0f
#define GAME_HEIGHT 750.0f

#pragma mark -
#pragma mark TIMER

#define STEP_INTERVAL 1/60.0f

#pragma mark -
#pragma mark ERROR_CODES

typedef enum
{
    LEVEL_EXISTS = 100
}error_codes;

#pragma mark -
#pragma mark OTHER

#define MIN_RATING -32768
#define MAX_RATIN 32767