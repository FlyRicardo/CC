//
//  WebServicesFactory.h
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebServicePromotionList;
@class WebServicePromotionsDetailListByCategory;
@class WebServiceArticleDetailById;

/** In the protocol, the methods of the "SPECIFIC PRODUCT" doesnt have the identifier to be created. This identifier is located on the  "GENERAL PRODUCT" , WebServiceFactory, who is responsable for create "an specific type of object"**/
@protocol WebServiceFactoryPrt

-(WebServicePromotionList *) createWebServicePromotionList;
-(WebServicePromotionsDetailListByCategory *) createWebServicePromotionsDetail;
-(WebServiceArticleDetailById*) createWebServiceArticleById;

@end


/** In the interface, the methods exposed by the "GENERAL PRODUCT" , recive a parammeter NSInteger for creating an "SPECIFIC PRODUCT"**/
@interface WebServiceFactory : NSObject

-(WebServicePromotionList *) createWebServicePromotionList:(NSInteger) type;
-(WebServicePromotionsDetailListByCategory *) createWebServicePromotionsDetail:(NSInteger) type;
-(WebServiceArticleDetailById*) createWebServiceArticleById:(NSInteger) identity;

@end
