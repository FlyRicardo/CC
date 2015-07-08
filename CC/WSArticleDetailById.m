//
//  WSArticleDetailById.m
//  CC
//
//  Created by Fly on 12/15/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "WSArticleDetailById.h"

#import "WSConnectionApache.h"

#import "ArticleMO.h"
#import "StoreMO.h"
#import "PhotoMO.h"
#import "PromotionMO.h"

@interface WSArticleDetailById ()

@property (nonatomic, strong) RKResponseDescriptor *responseDescriptor;
@property (nonatomic, strong) WSConnectionApache *wsConnectionApache;

@end

@implementation WSArticleDetailById

-(ArticleMO*) getArticleDetailWithId :(NSInteger ) identifier{
    [self configureRestKit];
    
    /**Adding parammeter to request **/
    //Parammeters
    NSNumber *articleId = [[NSNumber alloc] initWithInteger:identifier];
    NSDictionary *queryParams  = @{@"article_id":articleId};
    
    __block ArticleMO *articleById= nil;
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"CC/WS/WS_GetArticleById.php"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  articleById = [mappingResult.array objectAtIndex:0];
                                                  NSDictionary* userInfo = @{@"articleById": articleById};
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"ArticleByIdNotification" object:nil userInfo:userInfo];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no registers on CC/WS/WS_GetArticleById.php?': %@", error);
                                              }];
    
    return articleById;

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
                                                         @"articleDescription": @"descriptionArticle"
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
                                            pathPattern:@"/CC/WS/WS_GetArticleById.php"
                                                keyPath:@"response.Article"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [[_wsConnectionApache objectManager] addResponseDescriptor:_responseDescriptor];

}

@end
