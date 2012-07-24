//
//  Accelerators.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Accelerators.h"
#import "BoardItem.h"

@implementation Accelerators
@dynamic Level_ID;
@dynamic Rectangle;

- (NSArray*) getAcceleratorsforLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Accelerators" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate = [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    
    NSArray *pAccels = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return pAccels;
}

- (void) setAccelerators:(NSArray*)pAccels forLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    for (BoardItem* accel in pAccels) 
    {
        NSManagedObject* pNewObject = 
            [NSEntityDescription insertNewObjectForEntityForName:@"Accelerators" inManagedObjectContext:pMoc];
        [pNewObject setValue:(id)&level forKey:@"LevelID"];
        CGRect frame = accel.frame;
        [pNewObject setValue:(id)&frame forKey:@"Rectangle"];
    }
    if (![pMoc save: &pError]) 
    {
        NSLog(@"Error saving accelerators");
    }
}

@end
