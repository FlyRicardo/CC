//
//  CategoryMO.h
//  CC
//
//  Created by Fly on 11/24/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IconMO;

@interface CategoryMO : NSObject

@property (nonatomic) NSInteger categoryId;
@property (strong, nonatomic) NSString* name;
@property (nonatomic) NSInteger promotionCounts;
@property (strong, nonatomic) IconMO* iconMO;

@end
