//
//  StoreMO.h
//  CC
//
//  Created by Fly on 11/24/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreMO : NSObject

@property (nonatomic) NSInteger storeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@end
