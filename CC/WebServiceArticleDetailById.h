//
//  WebServiceArticleDetailById.h
//  CC
//
//  Created by Fly on 12/15/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleMO.h"

@protocol WebServiceArticleDetailByIdPrt
-(ArticleMO*) getArticleDetailWithId :(NSInteger ) identifier;
@end

@interface WebServiceArticleDetailById : NSObject
-(ArticleMO*) getArticleDetailWithId :(NSInteger ) identifier;
@end