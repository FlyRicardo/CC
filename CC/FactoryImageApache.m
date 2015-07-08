//
//  FactoryImageApache.m
//  CC
//
//  Created by Fly on 12/1/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "FactoryImageApache.h"
#import "ImageUtilityApache.h"

@implementation FactoryImageApache

#pragma make singleton
-(ImageUtility*) createImageUtility{
    ImageUtilityApache *imageUtilityApache = [[ImageUtilityApache alloc]init];
    return imageUtilityApache;
}

@end
