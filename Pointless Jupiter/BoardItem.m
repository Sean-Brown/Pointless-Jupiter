//
//  BoardItem.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardItem.h"
#import "Pointless_JupiterAppDelegate.h"

@implementation BoardItem

@synthesize m_stItemType, m_fOrientation;

- (id) initWithItem:(eImageTagID)mItem inFrame: (CGRect)frame
{
    // For some reason the x and y get screwed up
    CGRect correctRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    if (self == [super initWithFrame: correctRect]) 
    {
        self.m_stItemType = mItem;
        self.tag = mItem;
        UIImageView* item = [[UIImageView alloc] initWithFrame: correctRect];
        UIImage* itemImg;
        switch (mItem) 
        {
            case eitid_Accel:
                itemImg = [UIImage imageNamed:@"Accelerator.png"];
                item.image = itemImg;
                item.tag = eitid_Accel;
                break;
            case eitid_Trap:
                itemImg = [UIImage imageNamed:@"Trap.png"];
                item.image = itemImg;
                item.tag = eitid_Trap;
                break;
            case eitid_Whirl:
                itemImg = [UIImage imageNamed:@"Whirl.png"];
                item.image = itemImg;
                item.tag = eitid_Whirl;
                break;
            default:
                NSLog(@"WTF ITEM YOU GIVE ME MAN??");
                break;
        }
        [self addSubview: item];
    }
    m_fOrientation = 0.0;
    return self;
}

- (id) hitWall
{
    return self;
}

@end
