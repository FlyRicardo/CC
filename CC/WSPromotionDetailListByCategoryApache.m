//
//  WSPromotionDetailListByCategory.m
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "WSPromotionDetailListByCategoryApache.h"

#import "WSConnectionApache.h"

#import "ArticleMO.h"
#import "StoreMO.h"
#import "PhotoMO.h"
#import "PromotionMO.h"

@interface WSPromotionDetailListByCategoryApache()

@property (nonatomic, strong) RKResponseDescriptor *responseDescriptor;
@property (nonatomic, strong) WSConnectionApache *wsConnectionApache;

@end


@implementation WSPromotionDetailListByCategoryApache
-(NSArray *)getPromotionsDetailByCategory:(NSInteger) category_id{
    
    [self configureRestKit];
    
    /**Adding parammeter to request **/
    //Parammeters
    NSNumber *categoryId = [[NSNumber alloc] initWithInteger:category_id];
    NSDictionary *queryParams  = @{@"category_id":categoryId};
    
    __block NSArray *promotionListByCategory= nil;
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/CC/WS/WS_GetPromotionDetailsByCategory.php"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  promotionListByCategory = mappingResult.array;
                                                  NSDictionary* userInfo = @{@"promotionListByCategory": promotionListByCategory};
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"PromotionListByCategoryNotification" object:nil userInfo:userInfo];
                                              }
                                                failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no registers on WS_GetPromotionDetailsByCategory.php?': %@", error);
                                              }];
    
//    [[_wsConnectionApache objectManager] removeResponseDescriptor:_responseDescriptor];
    
    return promotionListByCategory;
}

-(void) configureRestKit
{
    // initialize RestKit
    _wsConnectionApache = [WSConnectionApache sharedWSConnectionApache];
    
    // setup object mappings
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[ArticleMO class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
                                                          @"articleId":@"articleId",
                                                          @"name":@"name",
                                                          @"price": @"price",
                                                          @"description": @"descriptionArticle"
                                                          }];
    
    // define icon objects mapping
    RKObjectMapping *storeMapping = [RKObjectMapping mappingForClass:[StoreMO class]];
    [storeMapping addAttributeMappingsFromArray:@[@"storeId", @"name", @"number" , @"latitude", @"longitude"]];
    
    RKObjectMapping *photoMapping =[RKObjectMapping mappingForClass: [PhotoMO class]];
    [photoMapping addAttributeMappingsFromArray:@[@"photoId", @"name", @"url", @"type"]];
    
    RKObjectMapping *promotionMapping = [RKObjectMapping mappingForClass: [PromotionMO class]];
    [promotionMapping addAttributeMappingsFromArray:@[@"promotionId", @"name", @"creationDate", @"percentageDiscount", @"effectiveness"]];
     
    // nesting Objects mapping
    [articleMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"storeVO" toKeyPath:@"storeMO" withMapping:storeMapping]];
    
    [articleMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photoVO" toKeyPath:@"photoMO" withMapping:photoMapping]];
    
    [articleMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"promotionVO" toKeyPath:@"promotionMO" withMapping:promotionMapping]];
    
    
    /**Register mappings with the provider using a response descriptor**/
    _responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:articleMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/CC/WS/WS_GetPromotionDetailsByCategory.php"
                                                keyPath:@"response.Articles"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [[_wsConnectionApache objectManager] addResponseDescriptor:_responseDescriptor];
}

@end
