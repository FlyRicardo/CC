//
//  FetchedResultController.h
//  CC
//
//  Created by Fly on 12/12/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol FetchedResultControllerPrt <NSObject>

+ (id)shareFetchedResultController;

- (NSFetchedResultsController *)getFetchedResultsController;
- (NSManagedObjectContext*) getManagedObjectdContext;
- (void) setManagedObjectdContextWithObject:(NSManagedObjectContext *) object;


@end

@interface FetchedResultController : NSObject

+ (id)shareFetchedResultController;

- (NSFetchedResultsController *)getFetchedResultsController;
- (NSManagedObjectContext*) getManagedObjectdContext;
- (void) setManagedObjectdContextWithObject:(NSManagedObjectContext *) object;

@end
