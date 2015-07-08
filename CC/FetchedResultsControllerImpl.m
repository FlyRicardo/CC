//
//  FetchedResultsController.m
//  CC
//
//  Created by Fly on 12/12/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "FetchedResultsControllerImpl.h"

@implementation FetchedResultsControllerImpl

#pragma mark - Singleton
+ (id)shareFetchedResultController{
    static FetchedResultsControllerImpl *fetchedResultsControllerImpl = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{fetchedResultsControllerImpl = [[self alloc]init];});
    return fetchedResultsControllerImpl;
}

-(id) init{
    if(self = [super init]){
    }
    return self;
}



#pragma mark - Fetched results controller
- (NSFetchedResultsController *)getFetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];

    [fetchRequest setSortDescriptors:sortDescriptors];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;

    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchedResultsController;
}

-(NSManagedObjectContext*) getManagedObjectdContext
{
    return _managedObjectContext;
}

- (void) setManagedObjectdContextWithObject:(NSManagedObjectContext *) object{
    self.managedObjectContext = object;
}

@end
