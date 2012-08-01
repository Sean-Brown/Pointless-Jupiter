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
    eAccelItem,
    eTrapItem,
    eWhirlItem
} MiscItem;


@interface BoardItem : UIView <JupiterDelegate>
{
    MyViewController* m_pMyVC;
    
    MiscItem m_stItemType;
}

@property (nonatomic, assign) MiscItem m_stItemType;

- (id) initWithItem:(MiscItem)mItem inFrame: (CGRect)frame;

@end