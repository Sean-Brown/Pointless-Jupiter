//  LevelBuilder.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// TODO: implement the bounds check for object overlap - or not?

#import <QuartzCore/QuartzCore.h>
#import "LevelBuilder.h"
#import "Pointless_JupiterAppDelegate.h"
#import "PhysicsEngine.h"
#import "Constants.h"

#define kWALL_RECT CGRectMake(300,200,10,500)
#define kTRAP_RECT CGRectMake(300,300,50,50)
#define kACCEL_RECT CGRectMake(300,300,60,20)
#define kWHIRL_RECT CGRectMake(300,300,50,50)
#define kJUPI_RECT CGRectMake(300,300,50,50)
#define kDEST_RECT CGRectMake(300,300,50,50)

//#define ROTATION_TESTING 1

@implementation LevelBuilder

@synthesize m_pItems, m_pTrap, m_pAccel, m_pWhirl, m_pWallImg, m_pJupi, m_pSelectedItemImage,
            m_pRemove, m_pDest, m_pSave, m_pQuit, m_pLevelID, m_pRotateButton;

#pragma mark -
#pragma mark INIT

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_nDestCount = 0;
        self.backgroundColor = [UIColor blackColor];
        m_pItems = [[NSMutableArray alloc] init];
        m_pSelectedItemImage = [[UIImageView alloc] init];
        m_pSelectedItemImage.userInteractionEnabled = YES;
        
        [self initImages:self];
        [self initGestures];
        [self initSaveQuit];
        [self initRotateButton];
        
        UILabel* pLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 130,
                                                                    kLANDSCAPE_HEIGHT - 150,
                                                                    100, 
                                                                    10)];
        pLabel.textColor = [UIColor purpleColor];
        pLabel.backgroundColor = [UIColor clearColor];
        pLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:14];
        pLabel.text = @"Level Name";
        m_pLevelID = [[UITextField alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 135,
                                                                   kLANDSCAPE_HEIGHT - 130,
                                                                   100, 
                                                                   20)];
        m_pLevelID.backgroundColor = [UIColor whiteColor];
        m_pLevelID.delegate = self;
        m_pLevelID.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
        [self addSubview: pLabel];
        [self addSubview: m_pLevelID];
        [pLabel setNeedsDisplay];
        
        m_bDoRotate = false;
        m_bRotating = false;
        m_bPinching = false;
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    m_pLevelID.frame = CGRectMake(0,
                                  0, 
                                  kLANDSCAPE_WIDTH, 
                                  kLANDSCAPE_HEIGHT - kLANDSCAPE_KEYBOARD_HEIGHT);
    [m_pLevelID setBackgroundColor:[UIColor whiteColor]];
    [m_pLevelID setText: textField.text];
    [m_pLevelID setFont: [UIFont fontWithName:@"AmericanTypewriter" size:60]];
    [m_pLevelID setTextAlignment: UITextAlignmentCenter];
    m_pLevelID.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [[m_pLevelID layer] setZPosition: 100000];
    [m_pLevelID setNeedsDisplay];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    m_pLevelID.frame = CGRectMake(kLANDSCAPE_WIDTH - 100,
                                  kLANDSCAPE_HEIGHT - 150, 
                                  100, 
                                  20);
    [m_pLevelID setFont: [UIFont fontWithName:@"AmericanTypeWriter" size:18]];
    [m_pLevelID setNeedsDisplay];
}

- (void)initSaveQuit
{
    m_pSave = [UIButton buttonWithType: UIButtonTypeCustom];
    m_pSave.frame = CGRectMake(kLANDSCAPE_WIDTH - 140,
                               kLANDSCAPE_HEIGHT - 100,
                               100, 
                               30);
    [m_pSave setTitle:@"Save" forState:UIControlStateNormal];
    [m_pSave setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [m_pSave addTarget:self action:@selector(saveLevel) forControlEvents:UIControlEventTouchUpInside];
    
    m_pQuit = [UIButton buttonWithType: UIButtonTypeCustom];
    m_pQuit.frame = CGRectMake(kLANDSCAPE_WIDTH - 140,
                               kLANDSCAPE_HEIGHT - 50, 
                               100, 
                               30);
    [m_pQuit setTitle:@"Quit" forState:UIControlStateNormal];
    [m_pQuit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_pQuit addTarget:self action:@selector(quitLevelBuilder) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: m_pSave];
    [self addSubview: m_pQuit];
}

- (void) initRotateButton
{
    m_pRotateButton = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 55,
                                                                 kLANDSCAPE_HEIGHT - 350,
                                                                 20,
                                                                 20)];
    [m_pRotateButton setImage:[UIImage imageNamed:@"RotateUnchecked.png"] forState:UIControlStateNormal];
    [m_pRotateButton addTarget:self action:@selector(checkBox) forControlEvents:UIControlEventTouchUpInside];
    m_bDoRotate = false;
    
    UILabel* pRotateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 150,
                                                                      kLANDSCAPE_HEIGHT - 350,
                                                                      85,
                                                                      20)];
    [pRotateLabel setText:@"Rotate Item"];
    pRotateLabel.textColor = [UIColor purpleColor];
    pRotateLabel.backgroundColor = [UIColor clearColor];
    pRotateLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:14];

    UITapGestureRecognizer* pTGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkBox)];
    pTGR.numberOfTapsRequired = 1;
    pTGR.numberOfTouchesRequired = 1;
    
    [m_pRotateButton addGestureRecognizer:pTGR];
    [self addSubview:m_pRotateButton];
    [self addSubview:pRotateLabel];
}

- (void) checkBox
{
    m_bDoRotate = !m_bDoRotate;
    if (!m_bDoRotate)
    {
        [m_pRotateButton setImage:[UIImage imageNamed:@"RotateUnchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [m_pRotateButton setImage:[UIImage imageNamed:@"RotateChecked.png"] forState:UIControlStateNormal];
    }
}

- (void)drawRect:(CGRect)rect
{
    for (int i = 0; i < kGAME_WIDTH; i+=10) 
    {
        for (int j = 0; j < kGAME_HEIGHT; j+=10) 
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
    m_pWallImg = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 120,   0, 50, 50)];
    m_pTrap    = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 120,  50, 50, 50)];
    m_pAccel   = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 120, 115, 50, 25)];
    m_pWhirl   = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 120, 150, 50, 50)];
    m_pJupi    = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 115, 205, 40, 40)];
    m_pDest    = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 120, 250, 50, 50)];
    m_pRemove  = [[UIButton alloc] initWithFrame:CGRectMake(kLANDSCAPE_WIDTH - 120, 350, 50, 50)];
    
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
    
    [m_pWallImg setTag: eitid_Wall];
    [m_pTrap setTag: eitid_Trap];
    [m_pAccel setTag: eitid_Accel];
    [m_pWhirl setTag: eitid_Whirl];
    [m_pJupi setTag: eitid_Jupiter];
    [m_pDest setTag: eitid_Dest];
    [m_pRemove setTag: eitid_Remove];
    
    [m_pWallImg setImage: [UIImage imageNamed: @"Wall.png"] forState: UIControlStateNormal];
    [m_pTrap setImage: [UIImage imageNamed: @"Trap.png"] forState:UIControlStateNormal];
    [m_pAccel setImage:[UIImage imageNamed: @"Accelerator.png"] forState: UIControlStateNormal];
    [m_pWhirl setImage:[UIImage imageNamed: @"Whirl.png"] forState:UIControlStateNormal];
    [m_pJupi setImage: [UIImage imageNamed:@"Jupiter.png"] forState:UIControlStateNormal];
    [m_pDest setImage: [UIImage imageNamed:@"Destination.png"] forState: UIControlStateNormal];
    [m_pRemove setImage: [UIImage imageNamed:@"Remove.png"] forState:UIControlStateNormal];
    
    [m_pWallImg setImage: [UIImage imageNamed: @"Wall.png"] forState: UIControlStateHighlighted];
    [m_pTrap setImage:[UIImage imageNamed: @"Trap.png"] forState:UIControlStateHighlighted];
    [m_pAccel setImage:[UIImage imageNamed: @"Accelerator.png"] forState: UIControlStateHighlighted];
    [m_pWhirl setImage:[UIImage imageNamed: @"Whirl.png"] forState: UIControlStateHighlighted];
    [m_pJupi setImage: [UIImage imageNamed:@"Jupiter.png"] forState: UIControlStateHighlighted];
    [m_pDest setImage: [UIImage imageNamed:@"Destination.png"] forState: UIControlStateNormal];
    [m_pRemove setImage: [UIImage imageNamed:@"Remove.png"] forState:UIControlStateHighlighted];
        
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
    [m_pWallImg addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [m_pTrap addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [m_pAccel addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [m_pWhirl addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [m_pJupi addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [m_pDest addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [m_pRemove addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPinchGestureRecognizer *pPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(processPinch:)];
    [pPinch setDelegate: self];
    [self addGestureRecognizer: pPinch];
}

#pragma mark -
#pragma SAVE_QUIT

- (void) saveLevelWithID:(NSString*)level
{
    NSMutableArray* walls = [[NSMutableArray alloc] init];
    NSMutableArray* accels = [[NSMutableArray alloc] init];
    NSMutableArray* traps = [[NSMutableArray alloc] init];
    NSMutableArray* whirls = [[NSMutableArray alloc] init];
    NSDictionary* pJupiterDict = newItemDictionary();
    NSDictionary* pDestDict = newItemDictionary();
    for (int i = 0; i < [m_pItems count]; i++) 
    {
        id object = [m_pItems objectAtIndex: i];
        switch ([object tag]) 
        {
            case eitid_Wall:
            {
                [walls addObject:object];
                [self printTransform:((Wall_Class*)object).transform];
                break;
            }
            case eitid_Trap:
                [traps addObject:object];
                break;
            case eitid_Accel:
            {
                [accels addObject:object];
                [self printTransform:((BoardItem*)object).transform];
                break;
            }
            case eitid_Whirl:
                [whirls addObject:object];
                break;
            case eitid_Jupiter:
                [pJupiterDict setValue: NSStringFromCGRect([object bounds]) forKey:@"a_Bounds"];
                [pJupiterDict setValue: NSStringFromCGPoint([object center]) forKey:@"a_Center"];
                [pJupiterDict setValue: NSStringFromCGAffineTransform(((UIImageView*)object).transform) forKey:@"a_Transform"];
                break;
            case eitid_Dest:
                [pDestDict setValue: NSStringFromCGRect([object bounds]) forKey:@"a_Bounds"];
                [pDestDict setValue: NSStringFromCGPoint([object center]) forKey:@"a_Center"];
                [pDestDict setValue: NSStringFromCGAffineTransform(((UIImageView*)object).transform) forKey:@"a_Transform"];
                break;
            default: 
                break;
        }
    }
    NSNumber* pRating = [NSNumber numberWithInt: 0];
    [[DataManager sharedDataManager] saveLevel:level traps:traps whirls:whirls accels:accels walls:walls dest:pDestDict jupiter:pJupiterDict rating:pRating];
}

- (void) printTransform:(CGAffineTransform)transform
{
    PhysicsEngine* pPE = [PhysicsEngine sharedPhysicsEngine];
    int aDegs = [pPE radiansToDegrees:transform.a];
    NSLog(@"Transform \"a\" radians = %f, degrees = %d", transform.a, aDegs);
    int bDegs = [pPE radiansToDegrees:transform.b];
    NSLog(@"Transform \"b\" radians = %f, degrees = %d", transform.b, bDegs);
    int cDegs = [pPE radiansToDegrees:transform.c];
    NSLog(@"Transform \"c\" radians = %f, degrees = %d", transform.c, cDegs);
    int dDegs = [pPE radiansToDegrees:transform.d];
    NSLog(@"Transform \"d\" radians = %f, degrees = %d", transform.a, dDegs);
    int txDegs = [pPE radiansToDegrees:transform.tx];
    NSLog(@"Transform \"tx\" radians = %f, degrees = %d", transform.a, txDegs);
    int tyDegs = [pPE radiansToDegrees:transform.ty];
    NSLog(@"Transform \"ty\" radians = %f, degrees = %d", transform.a, tyDegs);
}

- (void) saveLevel
{
//    NSString* pText = [m_pLevelID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* pText = m_pLevelID.text;
    if ([pText length] < 1) 
    { 
        UIAlertView* pAlert = [[UIAlertView alloc] initWithTitle:@"Enter A Name" message:@"You must first enter a (unique) name for your level" delegate:nil cancelButtonTitle:@"Return" otherButtonTitles:nil];
        pAlert.frame = CGRectMake(kLANDSCAPE_WIDTH / 3,
                                  kLANDSCAPE_HEIGHT / 3, 
                                  kLANDSCAPE_WIDTH / 3, 
                                  kLANDSCAPE_HEIGHT / 3);
        [pAlert show];
    }
    else if (m_nJupiCount == 0 || m_nDestCount == 0)
    { 
        UIAlertView* pAlert = [[UIAlertView alloc] initWithTitle:@"Incomplete Map" message:@"You must have Jupiter and a Sun" delegate:nil cancelButtonTitle:@"Return" otherButtonTitles:nil];
        pAlert.frame = CGRectMake(kLANDSCAPE_WIDTH / 3,
                                  kLANDSCAPE_HEIGHT / 3, 
                                  kLANDSCAPE_WIDTH / 3, 
                                  kLANDSCAPE_HEIGHT / 3);
        [pAlert show];
    }
    else
    { // Try and save it
        [self saveLevelWithID:pText];
    }
}

- (void) quitLevelBuilder
{
    [[MyViewController getMVC] toMainMenu];
    [self removeFromSuperview];
}

#pragma mark -
#pragma TOUCHES

- (void)selectItem: (id)sender
{
    // NSLog(@"Level Builder : Item Selected");
    if ([m_pItems count] > 25)
        return;
    NSInteger tid = ((UIButton*)sender).tag;
    id pNewImage;
    switch (tid) 
    {
        case eitid_Wall:
            pNewImage = [[Wall_Class alloc] initWithFrame: kWALL_RECT];
            [pNewImage setFrame: kWALL_RECT];
            [pNewImage setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [pNewImage setContentMode: UIViewContentModeScaleToFill];
            break;
        case eitid_Trap:
            pNewImage = [[BoardItem alloc] initWithItem: eitid_Trap inFrame: kTRAP_RECT];
            [pNewImage setFrame: kTRAP_RECT];
            break;
        case eitid_Accel:
            pNewImage = [[BoardItem alloc] initWithItem: eitid_Accel inFrame: kACCEL_RECT];
            [pNewImage setFrame: kACCEL_RECT];
            [pNewImage setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [pNewImage setContentMode: UIViewContentModeScaleToFill];
            break;
        case eitid_Whirl:
            pNewImage = [[BoardItem alloc] initWithItem: eitid_Whirl inFrame: kWHIRL_RECT];
            [pNewImage setFrame: kWHIRL_RECT];
            break;
        case eitid_Jupiter:
            if (m_nJupiCount == 0) 
            {
                pNewImage = [[UIImageView alloc] initWithFrame: kJUPI_RECT];
                [pNewImage setImage: [UIImage imageNamed:@"Jupiter.png"]];
                ++m_nJupiCount;
                [pNewImage setTag: eitid_Jupiter];
                break;
            }
            else
                return;
        case eitid_Dest:
            if (m_nDestCount < 1) 
            {
                pNewImage = [[UIImageView alloc] initWithFrame: kDEST_RECT];
                [pNewImage setImage: [UIImage imageNamed: @"Destination.png"]];
                ++m_nDestCount;
                [pNewImage setTag: eitid_Dest];
            }
            else
                return;
            break;
        default: 
            break;
    }
    if (m_pSelectedItemImage != nil) 
    {
        [m_pSelectedItemImage.layer setBorderColor: [UIColor clearColor].CGColor];
        [m_pSelectedItemImage.layer setBorderWidth: 0];
    }
    m_pSelectedItemImage = pNewImage;
    [m_pSelectedItemImage.layer setBorderColor: [UIColor yellowColor].CGColor];
    [m_pSelectedItemImage.layer setBorderWidth: 2.0];
    [pNewImage setUserInteractionEnabled: YES];
    [pNewImage setMultipleTouchEnabled: YES];
    [m_pItems addObject: pNewImage];
    [self addSubview: m_pSelectedItemImage];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_bDoRotate)
    {
        if (m_pRGR == nil)
        {
            if (m_pSelectedItemImage != nil)
            {
                m_pRGR = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(processRotate:) view:self items:m_pItems angle:atan2(m_pSelectedItemImage.transform.b, m_pSelectedItemImage.transform.a)];
            }
            else
            {
                m_pRGR = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(processRotate:) view:self items:m_pItems angle:0.0f];
            }
            [self addGestureRecognizer:m_pRGR];
        }
        [m_pRGR touchesBegan:touches withEvent:event];

        return;
    }
    else
    {
#ifndef ROTATION_TESTING
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        UIView *v = [self hitTest:touchPoint withEvent:event];
        if ([v isKindOfClass: [UIWindow class]] || [v isKindOfClass: [MyViewController class]] || [v isKindOfClass: [self class]]) 
        {
            return;
        }
        if (m_pSelectedItemImage != nil) 
        {
            [m_pSelectedItemImage.layer setBorderColor: [UIColor clearColor].CGColor];
            [m_pSelectedItemImage.layer setBorderWidth: 0];
        }
        m_pSelectedItemImage = (UIImageView *)v;
        [m_pSelectedItemImage.layer setBorderColor: [UIColor yellowColor].CGColor];
        [m_pSelectedItemImage.layer setBorderWidth: 2.0];
#endif
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_bDoRotate)
    {
        NSAssert(m_pRGR != nil, @"Rotation gesture recognizer is nil!");
        [m_pRGR touchesMoved:touches withEvent:event];
    }
    else
    {
#ifndef ROTATION_TESTING
        m_pSelectedItemImage.center = [[touches anyObject] locationInView: self];
#endif
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_bDoRotate)
    {
        NSAssert(m_pRGR != nil, @"Rotation gesture recognizer is nil!");
        [m_pRGR touchesEnded:touches withEvent:event];
        [self removeGestureRecognizer:m_pRGR];
        m_pRGR = nil;
    }
    else
    {
#ifndef ROTATION_TESTING
        if (m_pSelectedItemImage.tag == eitid_Wall)
        { // Walls are special
            int heightRadius = m_pSelectedItemImage.frame.size.height / 2;
            int widthRadius = m_pSelectedItemImage.frame.size.width / 2;
            if (m_pSelectedItemImage.center.x < widthRadius || 
                m_pSelectedItemImage.center.x > (kGAME_WIDTH - widthRadius) ||
                m_pSelectedItemImage.center.y < heightRadius ||
                m_pSelectedItemImage.center.y > (kGAME_HEIGHT - heightRadius))
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
                m_pSelectedItemImage.center.x > (kGAME_WIDTH - radius) ||
                m_pSelectedItemImage.center.y < radius ||
                m_pSelectedItemImage.center.y > (kGAME_HEIGHT - radius))
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
#endif
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_bDoRotate && m_pRGR != nil)
    {
        [m_pRGR touchesCancelled:touches withEvent:event];
    }
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
            int direction = (center.x + intersection.size.width) < kGAME_WIDTH ? 1 : 0;
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
                int direction = (center.y + intersection.size.height) < kGAME_HEIGHT ? 1 : 0;
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

// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
// Taken directly from the Apple example: https://developer.apple.com/library/ios/#samplecode/Touches/Listings/Touches_GestureRecognizers_Classes_MyViewController_m.html#//apple_ref/doc/uid/DTS40007435-Touches_GestureRecognizers_Classes_MyViewController_m-DontLinkElementID_11
- (void) adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)pGestureRecognizer
{
    if (pGestureRecognizer.state == UIGestureRecognizerStateBegan) 
    {
        UIView *piece = pGestureRecognizer.view;
        CGPoint locationInView = [pGestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [pGestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void) snapToGrid
{
    int x = m_pSelectedItemImage.center.x;
    int y = m_pSelectedItemImage.center.y;
    CGPoint center = m_pSelectedItemImage.center;
    if (m_pSelectedItemImage.tag == eitid_Wall)
    {
        int widthRadius = m_pSelectedItemImage.frame.size.width/2;
        int heightRadius = m_pSelectedItemImage.frame.size.height/2;
        
        if (x < widthRadius)
            center.x = widthRadius;
        else if (x > kGAME_WIDTH - widthRadius)
            center.x = kGAME_WIDTH - widthRadius;
        if (y < heightRadius)
            center.y = heightRadius;
        else if (y > kGAME_HEIGHT - heightRadius)
            center.y = kGAME_HEIGHT - heightRadius;
    }
    else
    {
        int radius = m_pSelectedItemImage.frame.size.width/2;
        
        if (x < radius)
            center.x = radius;
        else if (x > kGAME_WIDTH - radius)
            center.x = kGAME_WIDTH - radius;
        if (y < radius)
            center.y = radius;
        else if (y > kGAME_HEIGHT - radius)
            center.y = kGAME_HEIGHT - radius;
    }
    m_pSelectedItemImage.center = center;
}

- (void) processPinch: (UIPinchGestureRecognizer*)pPGR
{
    if (m_pSelectedItemImage == nil || m_bRotating)
        return;
    else
    {
        m_bPinching = true;
        [self adjustAnchorPointForGestureRecognizer:pPGR];
        switch (m_pSelectedItemImage.tag) 
        {
            case eitid_Jupiter:
            case eitid_Dest:
            case eitid_Trap:
            case eitid_Whirl:
                if (
                    pPGR.scale < 1 && // Pinch inwards
                    m_pSelectedItemImage.frame.size.width > 35 // Minimum width
                    ) 
                {
                    m_pSelectedItemImage.transform = CGAffineTransformScale(m_pSelectedItemImage.transform, pPGR.scale, pPGR.scale);
                }
                else if (
                         pPGR.scale > 1 && // Pinch outwards
                         m_pSelectedItemImage.frame.size.width < 65 // Maximum width
                         )
                {
                    m_pSelectedItemImage.transform = CGAffineTransformScale(m_pSelectedItemImage.transform, pPGR.scale, pPGR.scale);
                }
                break;
            case eitid_Accel:
                if (
                    pPGR.scale < 1 && // Pinch inwards
                    m_pSelectedItemImage.frame.size.width > 35 // Minimum width
                    ) 
                {
                    m_pSelectedItemImage.transform = CGAffineTransformScale(m_pSelectedItemImage.transform, pPGR.scale, pPGR.scale);
                }
                else if (
                         pPGR.scale > 1 && // Pinch inwards
                         m_pSelectedItemImage.frame.size.width < 100 // Maximum width
                         )
                {
                    m_pSelectedItemImage.transform = CGAffineTransformScale(m_pSelectedItemImage.transform, pPGR.scale, pPGR.scale);
                }
                break;
            case eitid_Wall:
                if ( 
                    pPGR.scale < 1 && // Pinch inwards
                    m_pSelectedItemImage.frame.size.height > 10 // Minimum height
                    ) 
                {
                    m_pSelectedItemImage.transform = CGAffineTransformScale(m_pSelectedItemImage.transform, pPGR.scale, pPGR.scale);
                }
                else if (
                         pPGR.scale > 1 && // Pinch inwards
                         m_pSelectedItemImage.frame.size.height < kGAME_HEIGHT // Maximum height
                         )
                {
                    m_pSelectedItemImage.transform = CGAffineTransformScale(m_pSelectedItemImage.transform, pPGR.scale, pPGR.scale);
                }
                break;
            default:
                return;
                break;
        }
    }
    m_bPinching = false;
}

- (void) processRotate: (KTOneFingerRotationGestureRecognizer*)pRGR
{
    if (m_pSelectedItemImage == nil || !(m_pSelectedItemImage.tag == eitid_Accel || m_pSelectedItemImage.tag == eitid_Wall) || m_bRotating)
        return;
    else if ([pRGR state] == UIGestureRecognizerStateBegan || [pRGR state] == UIGestureRecognizerStateChanged) 
    {
        NSLog(@"Rotation is %f radians", pRGR.rotation);
        CGFloat rotation = pRGR.rotation;
        m_bRotating = true;
        CGFloat oldOrientation = atan2(m_pSelectedItemImage.transform.b, m_pSelectedItemImage.transform.a);
        CGFloat newOrientation;
        NSLog(@"Old orientation = %f radians", oldOrientation);
        oldOrientation += rotation;
        if (oldOrientation >= M_PI * 2)
        {
            newOrientation = oldOrientation - (M_PI * 2);
            m_pSelectedItemImage.transform = CGAffineTransformMakeRotation(newOrientation);
        }
        else if (oldOrientation <= -(M_PI * 2))
        {
            newOrientation = oldOrientation + (M_PI * 2);
            m_pSelectedItemImage.transform = CGAffineTransformMakeRotation(newOrientation);
        }
        else
        {
            m_pSelectedItemImage.transform = CGAffineTransformMakeRotation(oldOrientation);
        }
        NSLog(@"New orientation = %f radians", ((BoardItem*)m_pSelectedItemImage).m_fOrientation);
    }
    m_bRotating = false;
}

- (void)removeItem: (id)sender
{
    if (m_pSelectedItemImage == nil || [m_pItems count] < 1)
        return;
    if ([m_pSelectedItemImage tag] == eitid_Jupiter) 
        --m_nJupiCount;
    if ([m_pSelectedItemImage tag] == eitid_Dest)    
        --m_nDestCount;
    // First remove from the items list, then from the view
    int index = [m_pItems indexOfObjectIdenticalTo: m_pSelectedItemImage];
    [m_pItems removeObjectAtIndex: index];
    UIImageView* pIV = m_pSelectedItemImage;
//    NSLog(@"Removing %@",pIV);
    [pIV removeFromSuperview];
    m_pSelectedItemImage = nil;
}

@end
