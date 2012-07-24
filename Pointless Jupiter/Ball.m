//
//  Ball.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"


@implementation Ball
@dynamic Level_ID;
@dynamic Rectangle;

- (NSArray*) getBallforLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Ball" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate =
    [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    
    NSArray *ball = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return ball;
}

- (void) setBall:(Jupiter*)pGameBall forLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSManagedObject* pNewObject = 
    [NSEntityDescription insertNewObjectForEntityForName:@"Ball" inManagedObjectContext:pMoc];
    [pNewObject setValue:(id)&level forKey:@"LevelID"];
    CGRect frame = pGameBall.frame;
    [pNewObject setValue:(id)&frame forKey:@"Rectangle"];
    if (![pMoc save: &pError]) 
    {
        NSLog(@"Error saving the game Ball");
    }
}

@end
