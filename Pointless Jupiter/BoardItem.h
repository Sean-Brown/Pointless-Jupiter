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
#import "Constants.h"

@interface BoardItem : UIImageView
{
    eImageTagID m_stItemType;
    CGFloat m_fOrientation;
}

@property (nonatomic) eImageTagID m_stItemType;
@property (nonatomic) CGFloat m_fOrientation;

- (id) initWithItem:(eImageTagID)mItem inFrame: (CGRect)frame;

@end