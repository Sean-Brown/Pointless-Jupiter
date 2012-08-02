//
//  Wall_Class.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall_Class.h"

@implementation Wall_Class

- (id) initWithFrame: (CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        UIImageView* wall = [[[UIImageView alloc] initWithFrame: frame] autorelease];
        UIImage* wallImage = [[UIImage imageNamed: @"Wall.jpg"] autorelease];
        wall.image = wallImage;
        [self addSubview: wall];
    }
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end
