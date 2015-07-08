//
//  LocalServiceFactoryImpl1.m
//  CC
//
//  Created by Fly on 12/12/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "LocalServiceFactoryImpl1.h"
#import "FetchedResultsControllerImpl.h"

static FetchedResultsControllerImpl *fetchedResultControllerImpl;

@implementation LocalServiceFactoryImpl1

-(id)init{
    self = [super init];
    if(self){
        fetchedResultControllerImpl = [FetchedResultsControllerImpl shareFetchedResultController];
    }
    return self;
}

-(FetchedResultController*) createFetchedResultControllerWithType:(NSInteger) type{
    switch (type) {
        case 0:
            return fetchedResultControllerImpl;
            break;
            
        default:
            return fetchedResultControllerImpl;
            break;
    }
}

@end
