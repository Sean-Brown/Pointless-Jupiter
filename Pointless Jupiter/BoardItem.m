//
//  BoardItem.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardItem.h"
#import "Constants.h"

@implementation BoardItem

@synthesize m_stItemType;

- (id) initWithItem:(MiscItem)mItem inFrame: (CGRect)frame
{
    if (self == [super init]) 
    {
        self.m_stItemType = mItem;
        self.tag = mItem;
        UIImageView* item = [[[UIImageView alloc] initWithFrame: frame] autorelease];
        UIImage* itemImg;
        switch (mItem) 
        {
            case eAccelItem:
                itemImg = [[UIImage imageNamed:@"Accelerator.jpg"] autorelease];
                item.image = itemImg;
                NSLog(@"Initializing an Accelerator");
                break;
            case eTrapItem:
                itemImg = [[UIImage imageNamed:@"Trap.jpg"] autorelease];
                item.image = itemImg;
                NSLog(@"Initializing a Trap");
                break;
            case eWhirlItem:
                itemImg = [[UIImage imageNamed:@"Whirl.jpg"] autorelease];
                item.image = itemImg;
                NSLog(@"Initializing a Whirl");
                break;
            default:
                NSLog(@"WTF ITEM YOU GIVE ME MAN??");
                break;
        }
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
