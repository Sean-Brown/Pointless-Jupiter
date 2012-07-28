//
//  LevelPicker.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelPicker : UITableViewCell <UITableViewDelegate>
{
    NSString* m_pLevelID;
    
    UIImageView* m_pJupiter;
    UIImageView* m_pDest;
    
    int m_nRating;
}

@property (nonatomic, copy) NSString* m_pLevelID;

- (void) setLevelID:(NSString*)levelID withRating:(NSNumber*)pRating;

@end
