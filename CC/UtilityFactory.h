//
//  UtilityFactory.h
//  CC
//
//  Created by Fly on 12/1/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageUtility;

@protocol UtilityFactoryPrt

-(ImageUtility*) createImageUtility;

@end

@interface UtilityFactory : NSObject

-(ImageUtility*) createImageUtility: (NSInteger) type;

@end
