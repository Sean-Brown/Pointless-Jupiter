//
//  Wall_Class.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall_Class.h"

@implementation Wall_Class

@synthesize m_fOrientation;

- (id) initWithFrame: (CGRect)frame
{
    CGRect correctRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    if (self == [super initWithFrame:correctRect])
    {
        UIImageView* wall = [[UIImageView alloc] initWithFrame: correctRect];
        UIImage* wallImage = [UIImage imageNamed: @"Wall.jpg"];
        wall.image = wallImage;
        [self addSubview: wall];
    }
    m_fOrientation = 0.0;
    return self;
}


@end
