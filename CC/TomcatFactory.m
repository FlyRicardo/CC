//
//  TomcatFactory.m
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TomcatFactory.h"
#import "WSPromotionListTomcat.h"
#import "WSPromotionDetailListByCategoryTomcat.h"
#import "WSArticleDetailById.h"

@implementation TomcatFactory

-(WebServicePromotionList *) createWebServicePromotionList{
    WSPromotionListTomcat *wsPromotionListTomcat = [[WSPromotionListTomcat alloc]init];
    return wsPromotionListTomcat;
}

-(WebServicePromotionsDetailListByCategory *) createWebServicePromotionsDetail{
    WSPromotionDetailListByCategoryTomcat *wsPromotionDetailListByCategoryTomcat = [[WSPromotionDetailListByCategoryTomcat alloc]init];
    return wsPromotionDetailListByCategoryTomcat;
}

-(WebServiceArticleDetailById*) createWebServiceArticleById{
    WebServiceArticleDetailById* webServiceArticleDetailById = [[WebServiceArticleDetailById alloc] init];
    return webServiceArticleDetailById;
}

@end
