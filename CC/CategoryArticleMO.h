//
//  CategoryArticleMO.h
//  CC
//
//  Created by Fly on 11/24/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryArticleMO : NSObject

@property (nonatomic) NSInteger categoryArticleId;
@property (nonatomic ) NSInteger categoryId;
@property (nonatomic ) NSInteger articleId;
@property (strong, nonatomic) NSString *descriptionC;

@end
