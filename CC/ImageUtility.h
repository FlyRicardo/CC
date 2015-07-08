//
//  ImageUtility.h
//  CC
//
//  Created by Fly on 12/1/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageUtilityPrt

-(Boolean) saveImageFromHttpURL : (NSString *) httpUrl withTypeOfImage:(NSInteger) type;
-(UIImage*) loadImageFromLocalURL : (NSString *) imageName withTypeOfImage:(NSInteger) type;

@end

@interface ImageUtility : NSObject

-(Boolean) saveImageFromHttpURL : (NSString *) httpUrl withTypeOfImage:(NSInteger) type;
-(UIImage*) loadImageFromLocalURL : (NSString *) imageName withTypeOfImage:(NSInteger) type;

@end