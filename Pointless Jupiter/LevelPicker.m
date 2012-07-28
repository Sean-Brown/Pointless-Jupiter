//
//  LevelPicker.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelPicker.h"
#import "Pointless_JupiterAppDelegate.h"

#define STAR_TAG 1988
#define BUDDHA_TAG 1989
#define JUPITER_TAG 1990
#define DESTINATION_TAG 1991

@implementation LevelPicker

@synthesize m_pLevelID;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        /*
         *  -------------------------------------------------------------
         * |                 LAYOUT OF UITABLEVIEWCELL                   |
         * --------------------------------------------------------------
         * |     backgroundView    - entire cell background              |
         * |selectedBackgroundView - entire cell background when selected|
         * |                                                             |
         * |     imageView         - cell's left                         |    
         * |     contentView       - cell's middle                       |
         * |     accessoryView     - cell's right                        |
         *  -------------------------------------------------------------
         *
         * For my purposes, I'll be using the imageView, contentView, and accessoryView,
         * but in the future I may look to get some cool custom backgrounds for the cells
         */
        
        int nFrameWidth = self.frame.size.width;
        int nFrameHeight = self.frame.size.height;
        int nOriginX = self.frame.origin.x;
        int nOriginY = self.frame.origin.y;

        // Initialization code
        // imageView
        [self.imageView initWithImage: [UIImage imageNamed: @"Buddha_Table.jpg"]];
        // Use the frame height for the width of this secton, since the Buddha pic is a square
        [self.imageView setFrame: CGRectMake(nOriginX, nOriginY, nFrameHeight, nFrameHeight)];
        [self.imageView setTag: BUDDHA_TAG];
        [self.imageView setUserInteractionEnabled: NO];
        [self addSubview: self.imageView];
        
        // contentView
        // nFrameWidth - nFrameHeight*2 since the imageView and contentView will have a width equal to the cell's height
        [self.contentView initWithFrame: CGRectMake(50, nOriginY, nFrameWidth - nFrameHeight, nFrameHeight)];
        m_pJupiter = [[UIImageView alloc] initWithFrame: CGRectMake(self.contentView.frame.origin.x, 0, nFrameHeight, nFrameHeight)];
        m_pDest = [[UIImageView alloc] initWithFrame: CGRectMake(self.contentView.frame.size.width - 50, 0, nFrameHeight, nFrameHeight)];
        m_pJupiter.image = [UIImage imageNamed:@"Jupiter.jpg"];
        m_pDest.image = [UIImage imageNamed:@"Destination.jpg"];
        [Pointless_JupiterAppDelegate roundImageCorners: m_pJupiter];
        [Pointless_JupiterAppDelegate roundImageCorners: m_pDest];
        [m_pJupiter setUserInteractionEnabled: YES];
        [m_pJupiter setMultipleTouchEnabled: NO];
        [m_pDest setUserInteractionEnabled: NO];
        m_pJupiter.tag = JUPITER_TAG;
        m_pDest.tag = DESTINATION_TAG;
        [self.contentView addSubview: m_pJupiter];
        [self.contentView addSubview: m_pDest];
        [self addSubview: self.contentView];
        
        // accessoryView
        // The accessory view should be the rating
        [self.accessoryView initWithFrame: CGRectMake(nFrameWidth - nFrameHeight, nOriginY, nFrameHeight, nFrameHeight)];
        UIImageView* pStar = [[[UIImageView alloc] initWithFrame: self.accessoryView.frame] autorelease];
        pStar.image = [UIImage imageNamed:@"GoldStar.jpg"];
        pStar.tag = STAR_TAG;
        [self.accessoryView addSubview: pStar];
        [self addSubview: self.accessoryView];
        // TODO: Query the RatedLevels table to see if the user's rated it already; if so, disable their ability to rate it again
        
    }
    return self;
}

- (void) setLevelID:(NSString*)levelID withRating:(NSNumber*)pRating
{
    // The label will be laid out to the left of the contentView, leaving room for Jupiter, an empty region, and the Destination (the Sun)
    int nFrameHeight = self.frame.size.height;
    UILabel* pLevelID = [[[UILabel alloc] initWithFrame: CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width - (nFrameHeight*3) , nFrameHeight)] autorelease];
    NSLog(@"levelID = %@, pLevelID.frame = %@",levelID,NSStringFromCGRect(pLevelID.frame));
    pLevelID.text = levelID;
    pLevelID.textColor = [UIColor purpleColor];
    pLevelID.shadowColor = [UIColor whiteColor];
    pLevelID.shadowOffset = CGSizeMake(2, 2);
    pLevelID.textAlignment = UITextAlignmentCenter;
    pLevelID.font = [UIFont fontWithName:@"Optima-BoldItalic" size: 32];
    pLevelID.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview: pLevelID];
    [self setNeedsDisplay];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    UIView *v = [self hitTest:touchPoint withEvent:event];
    if (v.tag != JUPITER_TAG) 
    {
        [v release];
        return;
    }
    else
    {
        m_pJupiter = (UIImageView*)v;
        [v release];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    m_pJupiter.center = [[touches anyObject] locationInView: self];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    if (m_pJupiter.center.x >= m_pDest.center.x) 
//    {
//        NSLog(@"OMG BEGIN THE LEVEL");
//    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self imageView] setFrame: CGRectMake(self.bounds.size.width/2+50, self.bounds.size.height/2, 50, 50)];
    [[self imageView] setNeedsDisplay];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state - animate Jupiter to rotate on axis
} 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return 75;
}

- (void) dealloc
{
    if (m_pLevelID != nil)
        [m_pLevelID release];
    [m_pJupiter release];
    [m_pDest release];
    [super dealloc];
}

@end
