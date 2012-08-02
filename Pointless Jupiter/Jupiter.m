//
//  Jupiter.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Jupiter.h"
#import "Pointless_JupiterAppDelegate.h"

@implementation Jupiter

@synthesize m_pMyVC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialize the game ball
        self.image = [UIImage imageNamed:@"Jupiter.jpg"];
        [Pointless_JupiterAppDelegate roundImageCorners: self];
    }
    return self;
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
    [super dealloc];
}

@end
