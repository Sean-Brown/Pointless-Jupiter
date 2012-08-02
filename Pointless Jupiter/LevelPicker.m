//
//  LevelPicker.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelPicker.h"
#import "Pointless_JupiterAppDelegate.h"

#define kPADDING 10.0f

@implementation LevelPicker

@synthesize m_pLevelID, m_pRating, m_pCT;

int nJupiterCenter = 0;

#pragma mark -
#pragma mark INITIALIZATION

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) 
    {
        self.contentMode = UIViewContentModeScaleAspectFit;
        [self.layer setBorderWidth: 5];
        [self.layer setBorderColor: [UIColor cyanColor].CGColor];
        
        bJupiterActive = false;
    }
    return self;
}

- (void) setLevelID:(NSString*)levelID withRating:(NSNumber*)pRating 
{
    m_pLevelID = levelID;
    [self makeLevelLabel:levelID];
    [self initJupiterAndDest];
    [self initRating: pRating];
}

- (void) makeLevelLabel:(NSString*)levelID
{
    int nX = self.bounds.origin.x;
    int nY = self.bounds.origin.y;
    int nW = self.bounds.size.width;
        
    UILabel* pLevelID = [[UILabel alloc] initWithFrame: CGRectMake(
                                                                   nX, 
                                                                   nY - (kPADDING * 2), 
                                                                   nW - kPADDING, 
                                                                   100
                                                                   )];
    pLevelID.text = levelID;
    pLevelID.textColor = [UIColor purpleColor];
    pLevelID.shadowColor = [UIColor whiteColor];
    pLevelID.shadowOffset = CGSizeMake(2, 2);
    pLevelID.textAlignment = UITextAlignmentCenter;
    pLevelID.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 32];
    pLevelID.backgroundColor = [UIColor clearColor];
    
    [self addSubview: pLevelID];
    [pLevelID release];
}

- (void) initJupiterAndDest
{
    int nX = self.bounds.origin.x;
    int nW = self.bounds.size.width;
    int nH = self.bounds.size.height;
    
    m_pJupiter = [[UIImageView alloc] initWithFrame: CGRectMake(
                                                                nX + kPADDING + 75, 
                                                                ((nH / 3.0) * 2.0) - kPADDING,
                                                                50, 
                                                                50
                                                                )];
    m_pJupiter.image = [UIImage imageNamed:@"Jupiter.jpg"];
    [Pointless_JupiterAppDelegate roundImageCorners: m_pJupiter];
    [m_pJupiter setUserInteractionEnabled: YES];
    [m_pJupiter setMultipleTouchEnabled: NO];
    
    m_pDest = [[UIImageView alloc] initWithFrame: CGRectMake(
                                                             (nW - 125 - kPADDING),
                                                             ((nH / 3.0) * 2.0) - kPADDING,
                                                             50,
                                                             50
                                                             )];
    m_pDest.image = [UIImage imageNamed:@"Destination.jpg"];
    [Pointless_JupiterAppDelegate roundImageCorners: m_pDest];
    [m_pDest setUserInteractionEnabled: NO];
    [m_pDest setMultipleTouchEnabled: NO];
    
    [self addSubview: m_pDest];
    [self addSubview: m_pJupiter];
}

- (void) initRating:(NSNumber*)pRating
{
    int nW = self.bounds.size.width;
    int nH = self.bounds.size.height;

    UIImageView* pRatingView = [[UIImageView alloc] initWithFrame: CGRectMake(
                                                                              (nW / 2.0) - 50 + kPADDING*2, 
                                                                              nH - 100 - 50 + kPADDING, 
                                                                              50, 
                                                                              50
                                                                              )];
    pRatingView.image = [UIImage imageNamed:@"GoldStar.jpg"];
    [m_pJupiter setUserInteractionEnabled: NO];
    [m_pJupiter setMultipleTouchEnabled: NO];
    // TODO: Query to find out if the user has already rated the level, if not, insert cevrons
    
    UILabel* pLabel = [[UILabel alloc] initWithFrame: CGRectMake(
                                                                pRatingView.bounds.origin.x, 
                                                                pRatingView.bounds.origin.y + (pRatingView.bounds.size.height / 2.0) - (kPADDING * 2), 
                                                                pRatingView.bounds.size.width,
                                                                (pRatingView.bounds.size.height / 2.0) + kPADDING
                                                                 )];
    pLabel.text = [pRating stringValue];
    pLabel.textColor = [UIColor redColor];
    pLabel.backgroundColor = [UIColor clearColor];
    pLabel.shadowColor = [UIColor purpleColor];
    pLabel.shadowOffset = CGSizeMake(2, 2);
    pLabel.textAlignment = UITextAlignmentCenter;
    pLabel.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 36];
    
    [pRatingView addSubview: pLabel];
    [self addSubview: pRatingView];
}

#pragma mark -
#pragma mark TOUCHES

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
//    NSLog(@"Touch at point %@", NSStringFromCGPoint(touchPoint));
    
    CGRect temp = CGRectMake(touchPoint.x, touchPoint.y, 1, 1);
    
    if (!CGRectIntersectsRect(m_pJupiter.frame, temp)) 
    {
        bJupiterActive = false;
        return;
    }
    else
        bJupiterActive = true;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (bJupiterActive)
    {
        m_pJupiter.center = [[touches anyObject] locationInView: self];
        CGPoint ptTemp = CGPointMake(110, 0);
        CGPoint ptNewCenter;
        if (m_pJupiter.center.x < ptTemp.x) 
            ptNewCenter = CGPointMake(ptTemp.x, m_pDest.center.y);
        else
            ptNewCenter = CGPointMake(m_pJupiter.center.x, m_pDest.center.y);
        [m_pJupiter setCenter: ptNewCenter];
        
        if (m_pJupiter.center.x >= m_pDest.center.x) 
        {
            if([m_pCT respondsToSelector:@selector(beginGameWithLevelID:)])
            {
                [m_pCT beginGameWithLevelID: m_pLevelID];
            }
        }
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Should never get here...");
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_pJupiter setFrame: CGRectMake(
                                     self.bounds.origin.x + kPADDING, 
                                     ((self.bounds.size.height / 3.0) * 2) - kPADDING,
                                     50, 
                                     50
                                     )];
    [m_pJupiter setNeedsDisplay];
}

- (void) dealloc
{
    if (m_pLevelID != nil)
        [m_pLevelID release];
    if (m_pRating != nil) 
        [m_pRating release];
    if (m_pJupiter != nil)
        [m_pJupiter release];
    if (m_pDest != nil)
        [m_pDest release];
    [super dealloc];
}

@end
