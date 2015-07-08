//
//  FetchedResultsController.h
//  CC
//
//  Created by Fly on 12/12/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchedResultController.h"


@interface FetchedResultsControllerImpl : FetchedResultController<FetchedResultControllerPrt,NSFetchedResultsControllerDelegate >

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end