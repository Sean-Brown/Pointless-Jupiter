//
//  Pointless_JupiterAppDelegate.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"

@interface Pointless_JupiterAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow* window;
    MyViewController* m_pMyVC;
}

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) MyViewController* m_pMyVC;

void uncaughtExceptionHandler(NSException *exception);

@end
