//
//  Destinaton.m
//  Pointless Jupiter
//
//  Created by Sean Brown on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Destinaton.h"

@implementation Destinaton
@dynamic Level_ID;
@dynamic Rectangle;

- (NSArray*) getDestinationforLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSFetchRequest* pRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* pEntity = [NSEntityDescription entityForName:@"Destination" inManagedObjectContext:pMoc];
    [pRequest setEntity:pEntity];
    NSPredicate* pPredicate =
    [NSPredicate predicateWithFormat:@"LevelID == %@", level];
    [pRequest setPredicate:pPredicate];
    
    
    NSArray *dest = [pMoc executeFetchRequest:pRequest error:&pError];
    
    return dest;
}

- (void) setDestinations:(NSArray*)pDests forLevel:(NSString*)level error:(NSError*)pError
{
    NSManagedObjectContext* pMoc = [self managedObjectContext];
    NSManagedObject* pNewObject = 
    [NSEntityDescription insertNewObjectForEntityForName:@"Destination" inManagedObjectContext:pMoc];
    [pNewObject setValue:(id)&level forKey:@"LevelID"];
    CGRect frame = [[pDests objectAtIndex:0] frame];
    [pNewObject setValue:(id)&frame forKey:@"Rectangle"];

    if (![pMoc save: &pError]) 
    {
        NSLog(@"Error saving Destination");
    }
}

@end
