//
//  Jupiter.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MyViewController.h"

@interface Jupiter : UIImageView {
    MyViewController* m_pMyVC;
}

@property (nonatomic, retain) MyViewController* m_pMyVC;

@end

@protocol JupiterDelegate <NSObject>

@end
