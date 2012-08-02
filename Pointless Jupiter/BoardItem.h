//
//  BoardItem.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyViewController.h"
#import "Jupiter.h"

// Enumeration for the 
typedef enum 
{
    emi_Accel,
    emi_Trap,
    emi_Whirl
} MiscItem;


@interface BoardItem : UIView <JupiterDelegate>
{
    MiscItem m_stItemType;
}

@property (nonatomic, assign) MiscItem m_stItemType;

- (id) initWithItem:(MiscItem)mItem inFrame: (CGRect)frame;

@end