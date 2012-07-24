//
//  Wall.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall.h"

@implementation Wall

- (id) init: WithBounds: (CGRect)bounds
{
    if (self == [super init])
    {
        UIImageView* wall = [[UIImageView alloc] initWithFrame: bounds];
        UIImage* wallImage = [UIImage imageNamed: @"Wall.jpg"];
        wall.image = wallImage;
    }
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end
