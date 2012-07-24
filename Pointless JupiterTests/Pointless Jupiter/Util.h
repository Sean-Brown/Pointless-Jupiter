//
//  Util.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "Constants.h"

// For resizing images
static UIImage* imageWithImage(UIImage* image, CGSize newSize) 
{ 
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0); 
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)]; 
    UIImage* pNewImage = UIGraphicsGetImageFromCurrentImageContext(); 
    UIGraphicsEndImageContext(); 
    
    return pNewImage; 
}

// My quick and inelegant way of making the frame stretch to portrait mode
CGRect makeScreen (CGRect frame)
{ 
    CGFloat _x = frame.origin.x;
    CGFloat _y = frame.origin.y;
    CGFloat _width = LANDSCAPE_WIDTH;
    CGFloat _height = frame.size.height;
    CGRect correctBounds = CGRectMake(_x, _y, _width, _height);
    return correctBounds;
}