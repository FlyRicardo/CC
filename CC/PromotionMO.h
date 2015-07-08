//
//  PromotionMO.h
//  CC
//
//  Created by Fly on 11/24/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionMO : NSObject

@property (nonatomic) NSInteger promotionId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSNumber *percentageDiscount;
@property (strong, nonatomic) NSNumber *effectiveness;

@end
