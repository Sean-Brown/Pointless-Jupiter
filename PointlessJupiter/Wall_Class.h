//
//  Wall_Class.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jupiter.h"

@interface Wall_Class : UIImageView <JupiterDelegate>  
{
    CGFloat m_fOrientation;
}

@property (nonatomic, assign) CGFloat m_fOrientation;

@end
