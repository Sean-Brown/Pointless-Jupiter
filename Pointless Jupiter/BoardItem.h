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
    Accelerator,
    Trap,
    Whirl
} MiscItem;


@interface BoardItem : UIView <JupiterDelegate>
{
    MyViewController* m_pMyVC;
    
    MiscItem m_stItemType;
}

@property (nonatomic, assign) MiscItem m_stItemType;

@end