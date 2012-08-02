//
//  BoardItem.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardItem.h"
#import "Constants.h"
#import "Pointless_JupiterAppDelegate.h"

@implementation BoardItem

@synthesize m_stItemType;

- (id) initWithItem:(MiscItem)mItem inFrame: (CGRect)frame
{
    if (self == [super initWithFrame:frame]) 
    {
        self.m_stItemType = mItem;
        self.tag = mItem;
        UIImageView* item = [[UIImageView alloc] initWithFrame: frame];
        UIImage* itemImg;
        switch (mItem) 
        {
            case emi_Accel:
                itemImg = [[UIImage imageNamed:@"Accelerator.jpg"] autorelease];
                item.image = itemImg;
                NSLog(@"Initializing an Accelerator");
                break;
            case emi_Trap:
                itemImg = [[UIImage imageNamed:@"Trap.jpg"] autorelease];
                item.image = itemImg;
                NSLog(@"Initializing a Trap");
                break;
            case emi_Whirl:
                itemImg = [[UIImage imageNamed:@"Whirl.jpg"] autorelease];
                item.image = itemImg;
                NSLog(@"Initializing a Whirl");
                break;
            default:
                NSLog(@"WTF ITEM YOU GIVE ME MAN??");
                break;
        }
        if (mItem == emi_Trap || mItem == emi_Whirl) 
            [Pointless_JupiterAppDelegate roundImageCorners:item];
        [self addSubview: item];
    }
    return self;
}

- (id) hitWall
{
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end
