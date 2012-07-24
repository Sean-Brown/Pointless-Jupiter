//
//  LevelBuilder.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// TODO: implement the bounds check for object overlap - or not?

#import <QuartzCore/QuartzCore.h>
#import "LevelBuilder.h"
#import "Constants.h"

#define WALL_RECT CGRectMake(300,300,300,10)
#define TRAP_RECT CGRectMake(300,300,50,50)
#define ACCEL_RECT CGRectMake(300,300,50,50)
#define WHIRL_RECT CGRectMake(300,300,50,50)
#define JUPI_RECT CGRectMake(300,300,50,50)
#define DEST_RECT CGRectMake(300,300,50,50)

typedef enum 
{
    WALL,
    TRAP,
    ACCELERATOR,
    WHIRL,
    JUPITER,
    DESTINATION,
    REMOVE
}ImageTagID;

@implementation LevelBuilder

@synthesize m_pMyVC, m_pItems, m_pJupiter, m_pTrap, m_pAccel, m_pWhirl, m_pWallImg, m_pJupi, m_pSelectedItemImage, m_pRemove, m_pDest, m_pSave, m_pQuit, m_pLevelID;

#pragma mark -
#pragma mark INIT

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_destCount = 0;
        self.backgroundColor = [UIColor blackColor];
        m_pItems = [[NSMutableArray alloc] init];
        m_pSelectedItemImage = [[UIImageView alloc] init];
        m_pSelectedItemImage.userInteractionEnabled = YES;
        
        [self initImages:self];
        [self initGestures];
        [self initSaveQuit];
        
        m_pLevelID = [[UITextField alloc] initWithFrame:CGRectMake(LANDSCAPE_WIDTH - 100, 450, 100, 20)];
        m_pLevelID.backgroundColor = [UIColor whiteColor];
        m_pLevelID.delegate = self;
        m_pLevelID.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
        [self addSubview: m_pLevelID];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    m_pLevelID.frame = CGRectMake(0, 0, LANDSCAPE_WIDTH, LANDSCAPE_HEIGHT-LANDSCAPE_KEYBOARD_HEIGHT);
    [m_pLevelID setBackgroundColor:[UIColor whiteColor]];
    [m_pLevelID setText: textField.text];
    [m_pLevelID setFont: [UIFont fontWithName:@"AmericanTypewriter" size:60]];
    [m_pLevelID setTextAlignment: UITextAlignmentCenter];
    m_pLevelID.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [m_pLevelID setNeedsDisplay];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    m_pLevelID.frame = CGRectMake(LANDSCAPE_WIDTH - 100, 450, 100, 20);
    [m_pLevelID setFont: [UIFont fontWithName:@"AmericanTypeWriter" size:18]];
    [m_pLevelID setNeedsDisplay];
}

- (void)initSaveQuit
{
    m_pSave = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    m_pSave.frame = CGRectMake(LANDSCAPE_WIDTH - 100, 500, 50, 50);
    [m_pSave setTitle:@"Save" forState:UIControlStateNormal];
    [m_pSave setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [m_pSave setBackgroundColor: [UIColor darkGrayColor]];
    [m_pSave addTarget:self action:@selector(saveLevel) forControlEvents:UIControlEventTouchUpInside];
    
    m_pQuit = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    m_pQuit.frame = CGRectMake(LANDSCAPE_WIDTH - 100, 550, 50, 50);
    [m_pQuit setTitle:@"Quit" forState:UIControlStateNormal];
    [m_pQuit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_pQuit setBackgroundColor: [UIColor darkGrayColor]];
    [m_pQuit addTarget:self action:@selector(quitLevelBuilder) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: m_pSave];
    [self addSubview: m_pQuit];
}

- (void)drawRect:(CGRect)rect
{
    for (int i = 0; i < GAME_WIDTH; i+=10) 
    {
        for (int j = 0; j < GAME_HEIGHT; j+=10) 
        {
            CGContextRef context= UIGraphicsGetCurrentContext();
            
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextSetAlpha(context, 0.5);
            CGContextFillEllipseInRect(context, CGRectMake(i, j, 2, 2));
        }
    }
}

- (void)initImages: (id)sender
{
    m_pWallImg     = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100,  0, 50, 50)];
    m_pTrap        = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100, 50, 50, 50)];
    m_pAccel       = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100, 100, 50, 50)];
    m_pWhirl       = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100, 150, 50, 50)];
    m_pJupi        = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100, 200, 50, 50)];
    m_pDest        = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100, 250, 50, 50)];
    m_pRemove      = [[UIButton alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH - 100, 350, 50, 50)];
    
    [m_pWallImg setUserInteractionEnabled: YES];
    [m_pTrap setUserInteractionEnabled: YES];
    [m_pAccel setUserInteractionEnabled: YES];
    [m_pWhirl setUserInteractionEnabled: YES];
    [m_pJupi setUserInteractionEnabled: YES];
    [m_pDest setUserInteractionEnabled:YES];
    [m_pRemove setUserInteractionEnabled: YES];
    
    [m_pWallImg.layer setBorderColor:[[UIColor redColor] CGColor]];
    [m_pTrap.layer setBorderColor:[[UIColor redColor] CGColor]];
    [m_pAccel.layer setBorderColor:[[UIColor redColor] CGColor]];
    [m_pWhirl.layer setBorderColor:[[UIColor redColor] CGColor]];
    [m_pJupi.layer setBorderColor:[[UIColor redColor] CGColor]];
    [m_pDest.layer setBorderColor:[[UIColor redColor] CGColor]];
    [m_pRemove.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [m_pWallImg setTag: WALL];
    [m_pTrap setTag: TRAP];
    [m_pAccel setTag: ACCELERATOR];
    [m_pWhirl setTag: WHIRL];
    [m_pJupi setTag: JUPITER];
    [m_pDest setTag: DESTINATION];
    [m_pRemove setTag: REMOVE];
    
    [m_pWallImg setImage: [UIImage imageNamed: @"Wall.jpg"] forState: UIControlStateNormal];
    [m_pTrap setImage: [UIImage imageNamed: @"Trap.jpg"] forState:UIControlStateNormal];
    [m_pAccel setImage:[UIImage imageNamed: @"Accelerator.jpg"] forState: UIControlStateNormal];
    [m_pWhirl setImage:[UIImage imageNamed: @"Whirl.jpg"] forState:UIControlStateNormal];
    [m_pJupi setImage: [UIImage imageNamed:@"Jupiter.jpg"] forState:UIControlStateNormal];
    [m_pDest setImage: [UIImage imageNamed:@"Dest.jpg"] forState: UIControlStateNormal];
    [m_pRemove setImage: [UIImage imageNamed:@"Remove.jpg"] forState:UIControlStateNormal];
    
    [m_pWallImg setImage: [UIImage imageNamed: @"Wall.jpg"] forState: UIControlStateHighlighted];
    [m_pTrap setImage:[UIImage imageNamed: @"Trap.jpg"] forState:UIControlStateHighlighted];
    [m_pAccel setImage:[UIImage imageNamed: @"Accelerator.jpg"] forState: UIControlStateHighlighted];
    [m_pWhirl setImage:[UIImage imageNamed: @"Whirl.jpg"] forState: UIControlStateHighlighted];
    [m_pJupi setImage: [UIImage imageNamed:@"Jupiter.jpg"] forState: UIControlStateHighlighted];
    [m_pDest setImage: [UIImage imageNamed:@"Dest.jpg"] forState: UIControlStateNormal];
    [m_pRemove setImage: [UIImage imageNamed:@"Remove.jpg"] forState:UIControlStateHighlighted];
    
    [sender addSubview: m_pWallImg];
    [sender addSubview: m_pTrap];
    [sender addSubview: m_pAccel];
    [sender addSubview: m_pWhirl];
    [sender addSubview: m_pJupi];
    [sender addSubview: m_pDest];
    [sender addSubview: m_pRemove];
}

- (void)initGestures
{   
    [m_pWallImg addTarget:self action:@selector(processTap:) forControlEvents:UIControlEventTouchUpInside];
    [m_pTrap addTarget:self action:@selector(processTap:) forControlEvents:UIControlEventTouchUpInside];
    [m_pAccel addTarget:self action:@selector(processTap:) forControlEvents:UIControlEventTouchUpInside];
    [m_pWhirl addTarget:self action:@selector(processTap:) forControlEvents:UIControlEventTouchUpInside];
    [m_pJupi addTarget:self action:@selector(processTap:) forControlEvents:UIControlEventTouchUpInside];
    [m_pDest addTarget:self action:@selector(processTap:) forControlEvents:UIControlEventTouchUpInside];
    [m_pRemove addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPinchGestureRecognizer *pPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(processPinch:)];
    [pPinch setDelegate: self];
    [pPinch setDelaysTouchesBegan:YES];
    [m_pSelectedItemImage addGestureRecognizer: pPinch];
    [pPinch release];
    
    UIRotationGestureRecognizer *pRot = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(processRotate:)];
    [pRot setDelegate: self];
    [m_pSelectedItemImage addGestureRecognizer: pRot];
    [pRot release];
}

#pragma mark -
#pragma SAVE_QUIT

- (void) saveLevel
{
    NSString* pText = m_pLevelID.text;
    if ([pText length] > 0) 
    { // Try and save it
        
    }
    else
    { // Tell them to enter one
        UIAlertView* pAlert = [[UIAlertView alloc] initWithFrame: CGRectMake(LANDSCAPE_WIDTH/3, LANDSCAPE_HEIGHT/3, LANDSCAPE_WIDTH/3, LANDSCAPE_HEIGHT/3)];
        [pAlert setTitle:@"Gimme A Name"];
        [pAlert setMessage:@"Enter a (unique) name for your level"];
        [pAlert setDelegate: self];;
        [self addSubview: pAlert];
        [pAlert release];
    }
}

- (void) quitLevelBuilder
{
    
}

#pragma mark -
#pragma TOUCHES

- (void)selectItem: (id)sender
{
    // NSLog(@"Level Builder : Item Selected");
    if ([m_pItems count] > 25)
        return;
    NSInteger tid = ((UIButton*)sender).tag;
    UIImageView* pNewImage;
    switch (tid) 
    {
        case WALL:
            // NSLog(@"WALL Selected");
            pNewImage = [[UIImageView alloc] initWithFrame: WALL_RECT];
            [pNewImage setImage: [UIImage imageNamed: @"Wall.jpg"]];
            break;
        case TRAP:
            // NSLog(@"TRAP Selected");
            pNewImage = [[UIImageView alloc] initWithFrame: TRAP_RECT];
            [pNewImage setImage: [UIImage imageNamed: @"Trap.jpg"]];
            break;
        case ACCELERATOR:
            // NSLog(@"ACCELERATOR Selected");
            pNewImage = [[UIImageView alloc] initWithFrame: ACCEL_RECT];
            [pNewImage setImage: [UIImage imageNamed: @"Accelerator.jpg"]];
            break;
        case WHIRL:
            // NSLog(@"WHIRL Selected");
            pNewImage = [[UIImageView alloc] initWithFrame: WHIRL_RECT];
            [pNewImage setImage: [UIImage imageNamed: @"Whirl.jpg"]];
            break;
        case JUPITER:
            // NSLog(@"JUPITER Selected");
            if (m_pJupiter == nil) 
            {
                m_pJupiter = [[[Jupiter alloc] initWithFrame: JUPI_RECT] retain];
                m_pJupiter.m_pMyVC = m_pMyVC;
                UIImage* pImage = [UIImage imageNamed: @"Jupiter.jpg"];
                m_pJupiter.image = pImage;
                [pImage release];
                
                m_pJupiter.opaque = YES;
                m_pJupiter.layer.cornerRadius = 25.0;
                m_pJupiter.layer.masksToBounds = YES;
                m_pJupiter.layer.borderColor = [UIColor blackColor].CGColor;
                m_pJupiter.layer.borderWidth = 1.0;
                
                [m_pJupiter setUserInteractionEnabled: YES];
                [m_pJupiter setMultipleTouchEnabled: YES];
                
                m_pSelectedItemImage = m_pJupiter;
                
                [m_pItems addObject: m_pSelectedItemImage];
        
                [self addSubview: m_pJupiter];
            }
            return;
            break;
        case DESTINATION:
            if (m_destCount < 1) 
            {
                pNewImage = [[UIImageView alloc] initWithFrame: DEST_RECT];
                [pNewImage setImage: [UIImage imageNamed: @"Dest.jpg"]];
                ++m_destCount;
            }
            else
                return;
            break;
        default: 
            break;
    }
    m_pSelectedItemImage = pNewImage;
    [pNewImage setUserInteractionEnabled: YES];
    [pNewImage setMultipleTouchEnabled: YES];
    [m_pItems addObject: pNewImage];
    [self addSubview: pNewImage];
    [pNewImage release];
}

- (void)processTap: (id)sender
{
    NSLog(@"Tapping item");
    [self selectItem: sender];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // NSLog(@"Touches began");
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    //our image views are direct decendents of our main view
    //the following method returns the farthest decendent from the target 
    //in the point, so make sure you dont have any intersecting subviews!
    //pretty sure you dont need event
    //
    UIView *v = [self hitTest:touchPoint withEvent:event];
    if ([v isKindOfClass: [UIWindow class]] || [v isKindOfClass: [MyViewController class]] || [v isKindOfClass: [self class]]) 
    {
        return;
    }
    m_pSelectedItemImage = (UIImageView *)v;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    m_pSelectedItemImage.center = [[touches anyObject] locationInView: self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_pSelectedItemImage.tag == WALL)
    { // Walls are special
        int heightRadius = m_pSelectedItemImage.frame.size.height/2;
        int widthRadius = m_pSelectedItemImage.frame.size.width/2;
        if (m_pSelectedItemImage.center.x < widthRadius || 
            m_pSelectedItemImage.center.x > (GAME_WIDTH - widthRadius) ||
            m_pSelectedItemImage.center.y < heightRadius ||
            m_pSelectedItemImage.center.y > (GAME_HEIGHT - heightRadius))
        {
            [self snapToGrid];
        }
        else
        {
            // NSLog(@"Center is at (%f,%f)", m_pSelectedItemImage.center.x, m_pSelectedItemImage.center.y);
        }
    }
    else
    {
        int radius = m_pSelectedItemImage.frame.size.width/2;
        if (m_pSelectedItemImage.center.x < radius || 
            m_pSelectedItemImage.center.x > (GAME_WIDTH - radius) ||
            m_pSelectedItemImage.center.y < radius ||
            m_pSelectedItemImage.center.y > (GAME_HEIGHT - radius))
        {
            [self snapToGrid];
        }
        else
        {
            // NSLog(@"Center is at (%f,%f)", m_pSelectedItemImage.center.x, m_pSelectedItemImage.center.y);
        }
    }
    // if ([m_pItems count] > 1)
        // [self checkOverlap];
}

- (void)checkOverlap
{
    CGRect selFrame = m_pSelectedItemImage.frame;
    CGRect itemFrame = [[m_pItems objectAtIndex:0] frame];
    while (CGRectIntersectsRect(selFrame, itemFrame))
    {
        for (int i = 0; i < [m_pItems count]; i++)
        {
            if ((UIImageView*)[m_pItems objectAtIndex:i] != m_pSelectedItemImage) {
                continue;
            }
            itemFrame = [[m_pItems objectAtIndex: i] frame];
            CGRect intersection = CGRectIntersection(selFrame, itemFrame);
            CGPoint center = m_pSelectedItemImage.center;
            // 0 = LEFT , 1 = RIGHT
            int direction = (center.x + intersection.size.width) < GAME_WIDTH ? 1 : 0;
            if (direction == 0)
            {
                center.x -= intersection.size.width;
            }
            else
            {
                center.x += intersection.size.width;
            }
            m_pSelectedItemImage.center = center;
            selFrame = m_pSelectedItemImage.frame;
            if (CGRectIntersectsRect(selFrame, itemFrame))
            { 
                // 0 = UP , 1 = DOWN
                int direction = (center.y + intersection.size.height) < GAME_HEIGHT ? 1 : 0;
                if (direction == 0) 
                {
                    center.y -= intersection.size.height;
                }
                else
                {
                    center.y += intersection.size.height;
                }
            }
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    m_pSelectedItemImage = nil;
}

- (void)snapToGrid
{
    int x = m_pSelectedItemImage.center.x;
    int y = m_pSelectedItemImage.center.y;
    CGPoint center = m_pSelectedItemImage.center;
    if (m_pSelectedItemImage.image == [UIImage imageNamed:@"Wall.jpg"])
    {
        int widthRadius = m_pSelectedItemImage.frame.size.width/2;
        int heightRadius = m_pSelectedItemImage.frame.size.height/2;
        
        if (x < widthRadius)
            center.x = widthRadius;
        else if (x > GAME_WIDTH - widthRadius)
            center.x = GAME_WIDTH - widthRadius;
        if (y < heightRadius)
            center.y = heightRadius;
        else if (y > GAME_HEIGHT - heightRadius)
            center.y = GAME_HEIGHT - heightRadius;
    }
    else
    {
        int radius = m_pSelectedItemImage.frame.size.width/2;
        
        if (x < radius)
            center.x = radius;
        else if (x > GAME_WIDTH - radius)
            center.x = GAME_WIDTH - radius;
        if (y < radius)
            center.y = radius;
        else if (y > GAME_HEIGHT - radius)
            center.y = GAME_HEIGHT - radius;
    }
    m_pSelectedItemImage.center = center;
}

- (void)processPinch: (id)sender
{
    NSLog(@"Pinching item");
}

- (void)processRotate: (id)sender
{
    NSLog(@"Rotating item");
    [self selectItem: sender];
}

- (void)removeItem: (id)sender
{
    if (m_pSelectedItemImage == nil || [m_pItems count] < 1)
        return;
    if ([m_pSelectedItemImage isKindOfClass: [Jupiter class]]) 
        m_pJupiter = nil;
    if ([m_pSelectedItemImage tag] == DESTINATION)    
        --m_destCount;
    // First remove from the items list, then from the view
    int index = [m_pItems indexOfObjectIdenticalTo: m_pSelectedItemImage];
    [m_pItems removeObjectAtIndex: index];
    UIImageView* pIV = m_pSelectedItemImage;
    NSLog(@"Removing %@",pIV);
    [pIV removeFromSuperview];
    m_pSelectedItemImage = nil;
}

- (void)dealloc
{
    [super dealloc];
    [m_pSelectedItemImage dealloc];
    [m_pJupi dealloc];
    [m_pJupiter dealloc];
    [m_pItems dealloc];
    [m_pAccel dealloc];
    [m_pTrap dealloc];
    [m_pWallImg dealloc];
    [m_pWhirl dealloc];
    [m_pDest dealloc];
    [m_pLevelID dealloc];
}

@end
