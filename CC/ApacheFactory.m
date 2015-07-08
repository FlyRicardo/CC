//
//  ApacheFactory.m
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "ApacheFactory.h"
#import "WSPromotionListApache.h"
#import "WSPromotionDetailListByCategoryApache.h"
#import "WSArticleDetailById.h"

@implementation ApacheFactory

-(WebServicePromotionList *) createWebServicePromotionList{
    WSPromotionListApache *wsPromotionListApache = [[WSPromotionListApache alloc]init];
    return wsPromotionListApache;
}

-(WebServicePromotionsDetailListByCategory *) createWebServicePromotionsDetail{
    WSPromotionDetailListByCategoryApache *wsPromotionDetailListByCategoryApache = [[WSPromotionDetailListByCategoryApache alloc]init];
    return wsPromotionDetailListByCategoryApache;
}

-(WebServiceArticleDetailById*) createWebServiceArticleById{
    WSArticleDetailById* wsArticleDetailById = [[WSArticleDetailById alloc] init];
    return wsArticleDetailById;
}

@end
