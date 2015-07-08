//
//  ArticleOM.h
//  CC
//
//  Created by Fly on 11/24/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoreMO;
@class PhotoMO;
@class PromotionMO;

@interface ArticleMO : NSObject

@property (nonatomic) NSInteger articleId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *descriptionArticle;

@property (strong, nonatomic) StoreMO *storeMO;
@property (strong, nonatomic) PhotoMO *photoMO;
@property (strong, nonatomic) PromotionMO *promotionMO;

@end
