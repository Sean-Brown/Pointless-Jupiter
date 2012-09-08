//
//  PhysicsEngine.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 9/4/12.
//
//

#import "PhysicsEngine.h"

@implementation PhysicsEngine

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
    m_dUpdateInterval = dUpdateInterval;
    m_fDirection = 0.0f;
    m_fSpeed = 0.0f;
    m_pStaticObjects = [[NSMutableDictionary alloc] init];

    return self;
}

- (void) calcCollision
{
    
}

- (void) updateJupiter:(float)fNewSpeed withAngle:(float)fNewAngle
{
    
}

- (CGRect) getJupiterFrame
{
    return m_JupiterFrame;
}

- (void) startTimer
{
    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:m_dUpdateInterval
                                                target:self
                                              selector:@selector(calcCollision)
                                              userInfo:nil
                                               repeats:YES];
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
