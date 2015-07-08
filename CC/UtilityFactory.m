//
//  UtilityFactory.m
//  CC
//
//  Created by Fly on 12/1/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "UtilityFactory.h"
#import "ImageUtility.h"
#import "FactoryImageApache.h"


static FactoryImageApache *factoryImageApache;

@implementation UtilityFactory

-(id)init{
    self = [super init];
    if(self){
        factoryImageApache = [[FactoryImageApache alloc]init];
    }
    return self;
}

-(ImageUtility *) createImageUtility : (NSInteger) type{
    switch (type) {
        case 0:
            return [factoryImageApache createImageUtility];
            break;
        default:
            return [factoryImageApache createImageUtility];
            break;
    }
}

@end
