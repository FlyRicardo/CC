//
//  LocalServiceFactory.h
//  CC
//
//  Created by Fly on 12/12/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FetchedResultController;

@protocol LocalServiceFactoryPrt <NSObject>

-(FetchedResultController*) createFetchedResultControllerWithType:(NSInteger) type;

@end

@interface LocalServiceFactory : NSObject

-(FetchedResultController*) createFetchedResultControllerWithType:(NSInteger) type;

@end
