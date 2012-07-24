//
//  Whirls.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Whirls.h"
#import "BoardItem.h"

@implementation Whirls
@dynamic Level_ID;
@dynamic Rectangle;

- (NSArray*) getWhirlsforLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Walls" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate =
    [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    NSArray *pWhirls = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return pWhirls;
}

- (void) setWalls:(NSArray*)pWhirls forLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    for (BoardItem* whirl in pWhirls) 
    {
        NSManagedObject* pNewObject = 
        [NSEntityDescription insertNewObjectForEntityForName:@"Whirl" inManagedObjectContext:pMoc];
        [pNewObject setValue:(id)&level forKey:@"LevelID"];
        CGRect frame = whirl.frame;
        [pNewObject setValue:(id)&frame forKey:@"Rectangle"];
    }
    if (![pMoc save: &pError]) 
    {
        NSLog(@"Error saving whirls");
    }
}

@end
