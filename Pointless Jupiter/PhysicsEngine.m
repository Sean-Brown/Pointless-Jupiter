//
//  PhysicsEngine.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 9/4/12.
//
//

#import "PhysicsEngine.h"

#define kFRICTION 0.1f
#define kUPDATEINTERVAL 0.1f

@implementation PhysicsEngine
@synthesize m_JupiterFrame;

+ (PhysicsEngine*) sharedPhysicsEngine
{
    static PhysicsEngine* pSharedEngine;
    @synchronized (pSharedEngine)
    {
        if( !pSharedEngine )
            pSharedEngine = [[PhysicsEngine alloc] initWithFriction:kFRICTION updateInterval:kUPDATEINTERVAL];
        
        return pSharedEngine;
    }
}

+ (PhysicsEngine*) sharedPhysicsEngine:(double)dFriction updateInterval:(double)dUpdateInterval
{
    if (dFriction < 0 || dUpdateInterval <= 0)
    { // That's right, we can have a frictionless game (more like outer space I guess)
        [NSException raise:@"INVALID PARAMETERS"
                    format:@"Friction and UpdateInterval need to be positive doubles."];
    }
    
    static PhysicsEngine* pSharedEngine;
    @synchronized (pSharedEngine)
    {
        if( !pSharedEngine )
            pSharedEngine = [[PhysicsEngine alloc] initWithFriction:dFriction updateInterval:dUpdateInterval];

        return pSharedEngine;
    }
}

- (id) initWithFriction:(double)dFriction updateInterval:(double)dUpdateInterval
{
    m_dFriction = dFriction;
    m_UpdateInterval =  dUpdateInterval;
    m_fDirection = 0.0f;
    m_fSpeed = 0.0f;

    return self;
}

- (void) calcCollision
{

    CGRect jupiterFrame = CGRectMake(arc4random_uniform(400),
                                     arc4random_uniform(400),
                                     50,
                                     50
                                     );
    [self willChangeValueForKey:@"m_JupiterFrame"];
    m_JupiterFrame = jupiterFrame;
    [self didChangeValueForKey:@"m_JupiterFrame"];
}

- (void) updateJupiter:(float)fNewSpeed withAngle:(float)fNewAngle
{
    
}

- (void) startTimer
{
//    NSLog(@"Starting the PhysicsEngine's timer");
    if (![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(beginTimerInMainThread) withObject:nil waitUntilDone:NO];
    }
    else
    {
        m_pTimer = [NSTimer scheduledTimerWithTimeInterval:m_UpdateInterval
                                                    target:self
                                                  selector:@selector(calcCollision)
                                                  userInfo:nil
                                                   repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:m_pTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void) beginTimerInMainThread
{
    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:m_UpdateInterval
                                                target:self
                                              selector:@selector(calcCollision)
                                              userInfo:nil
                                               repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:m_pTimer forMode:NSDefaultRunLoopMode];
}

- (void) stopTimer
{
    if([m_pTimer isValid])
    {
        [m_pTimer invalidate];
        m_pTimer = nil;
    }
}

@end
