//
//  WebServiceFactory.m
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceFactory.h"
#import "ApacheFactory.h"
#import "TomcatFactory.h"

static ApacheFactory *apacheFactory;
static TomcatFactory *tomcatFactory;

@implementation WebServiceFactory

-(id)init{
    self = [super init];
    if(self){
        apacheFactory = [[ApacheFactory alloc]init];
        tomcatFactory  = [[TomcatFactory alloc]init];
    }
    return self;
}

-(WebServicePromotionList *) createWebServicePromotionList : (NSInteger) type{
    switch (type) {
        case 0:
            return [apacheFactory createWebServicePromotionList];
            break;
        case 1:
             return [tomcatFactory createWebServicePromotionList];
            break;
            
        default:
            return [apacheFactory createWebServicePromotionList];
            break;
    }
}

-(WebServicePromotionsDetailListByCategory *) createWebServicePromotionsDetail: (NSInteger) type{
    switch (type) {
        case 0:
            return [apacheFactory createWebServicePromotionsDetail];
            break;
        case 1:
            return [tomcatFactory createWebServicePromotionsDetail];
            break;
            
        default:
            return [apacheFactory createWebServicePromotionsDetail];
            break;
    }

}

-(WebServiceArticleDetailById*) createWebServiceArticleById:(NSInteger)identity{
    switch (identity) {
        case 0:
            return [apacheFactory createWebServiceArticleById];
            break;
        case 1:
            return [tomcatFactory createWebServiceArticleById];
            break;
            
        default:
            return [apacheFactory createWebServiceArticleById];
            break;
    }
}
@end