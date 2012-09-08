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
@private
    NSTimer* m_pTimer;
    
    CGRect m_JupiterFrame; // The frame of the game ball (i.e. "Jupiter")
    NSMutableDictionary* m_pStaticObjects; // The dictionary of static objects, containing the object type, its frame, and its orientation
    
    float m_fSpeed; // Speed of Jupiter's movement
    float m_fDirection; // Direction of Jupiter's movement
    
    double m_dUpdateInterval; // How frequently the items should update
    double m_dFriction; // How much friction should there be? Let the user choose (for LevelBuilder)?
}

@property (nonatomic, strong) NSTimer* m_pTimer;
@property (nonatomic, strong) NSMutableDictionary* m_pStaticObjects;
@property (nonatomic) double m_dUpdateInterval;
@property (nonatomic) double m_dFriction;

+ (PhysicsEngine*) sharedPhysicsEngine:(double)dFriction updateInterval:(double)dUpdateInterval;
- (id) initWithFriction:(double)dFriction updateInterval:(double)dUpdateInterval;
- (void) calcCollision;
- (void) updateJupiter:(float)fNewSpeed withAngle:(float)fNewAngle; // Updates Jupiter's speed and direction (e.g. velocity).
- (CGRect) getJupiterFrame; // Getter for Jupiter's frame
- (void) startTimer;
- (void) stopTimer;

@end
