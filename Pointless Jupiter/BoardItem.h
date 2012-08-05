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
} eMiscItem;


@interface BoardItem : UIView <JupiterDelegate>
{
    eMiscItem m_stItemType;
}

@property (nonatomic, assign) eMiscItem m_stItemType;

- (id) initWithItem:(eMiscItem)mItem inFrame: (CGRect)frame;

@end