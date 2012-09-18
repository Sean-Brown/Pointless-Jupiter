//
//  PhysicsEngine.h
//  Pointless Jupiter
//
//  Created by Sean Brown on 9/4/12.
//
//

#import <Foundation/Foundation.h>

@interface PhysicsEngine : NSObject
{
@public
    CGRect m_JupiterFrame; // The frame of the game ball (i.e. "Jupiter")
    NSDictionary* m_pStaticObjects; // The dictionary of static objects, containing the object type, its frame, and its orientation
@private
    NSTimer* m_pTimer;
    NSTimeInterval m_UpdateInterval; // How frequently the items should update
    
    float m_fSpeed; // Speed of Jupiter's movement
    float m_fDirection; // Direction of Jupiter's movement
    
    double m_dFriction; // How much friction should there be? Let the user choose (for LevelBuilder)?
}

@property (nonatomic, strong) NSTimer* m_pTimer;
@property (nonatomic, strong) NSDictionary* m_pStaticObjects;
@property (nonatomic) CGRect m_JupiterFrame;
@property (nonatomic) NSTimeInterval m_UpdateInterval;
@property (nonatomic) double m_dFriction;

+ (PhysicsEngine*) sharedPhysicsEngine; // Uses default values
+ (PhysicsEngine*) sharedPhysicsEngine:(double)dFriction updateInterval:(double)dUpdateInterval;

- (id) initWithFriction:(double)dFriction updateInterval:(double)dUpdateInterval;
- (void) calcCollision;
- (void) updateJupiter:(float)fNewSpeed withAngle:(float)fNewAngle; // Updates Jupiter's speed and direction (e.g. velocity).
- (void) startTimer;
- (void) beginTimerInMainThread;
- (void) stopTimer;

- (int)radiansToDegrees:(CGFloat)dRadians;
- (CGFloat)degreesToRadians:(CGFloat)dDegrees;

@end
