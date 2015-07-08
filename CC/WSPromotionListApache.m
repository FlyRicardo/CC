//
//  ConnectionDB_MYSQL.m
//  CC
//
//  Created by Fly on 11/24/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "WSPromotionListApache.h"
#import "WSConnectionApache.h"
#import "CategoryMO.h"
#import "IconMO.h"
#import "MetaMO.h"


@interface WSPromotionListApache ()

@property (nonatomic, strong) RKResponseDescriptor *responseDescriptorMeta;
@property (nonatomic, strong) RKResponseDescriptor *responseDescriptor;
@property (nonatomic, strong) WSConnectionApache *wsConnectionApache;

@end

@implementation WSPromotionListApache

-(NSArray *)getPromotionList{
    
    [self configureRestKit];
    
    __block NSArray *promotionList= nil;
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/CC/WS/WS_GetCategoriesWithCountOfPromotions.php"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  promotionList = mappingResult.array;
                                                  NSDictionary* userInfo = @{@"promotionList": promotionList};
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"PromotionListNotification" object:nil userInfo:userInfo];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no registers on WS_GetCategoriesWithCountOfPromotions.php?': %@", error);
                                              }];
    
    [[_wsConnectionApache objectManager] removeResponseDescriptor:_responseDescriptor];
    
    return promotionList;
}


-(void) configureRestKit
{
    // initialize RestKit
    _wsConnectionApache = [WSConnectionApache sharedWSConnectionApache];
    
    // setup object mappings
    RKObjectMapping *categoryMapping = [RKObjectMapping mappingForClass:[CategoryMO class]];
    [categoryMapping addAttributeMappingsFromDictionary:@{
                                                          @"categoryId":@"categoryId",
                                                          @"name":@"name",
                                                          @"promotionCounts":@"promotionCounts",
                                                          }];
    
    // define icon object mapping
    RKObjectMapping *iconMapping = [RKObjectMapping mappingForClass:[IconMO class]];
    [iconMapping addAttributeMappingsFromArray:@[@"iconId", @"name", @"url"]];
    
    // nesting Objects mapping
    [categoryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"iconVO" toKeyPath:@"iconMO" withMapping:iconMapping]];
    
    
    // register mappings with the provider using a response descriptor
    _responseDescriptor =
        [RKResponseDescriptor responseDescriptorWithMapping:categoryMapping
                                                     method:RKRequestMethodGET
                                                pathPattern:@"/CC/WS/WS_GetCategoriesWithCountOfPromotions.php"
                                                    keyPath:@"response.Categories"
                                                statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [[_wsConnectionApache objectManager] addResponseDescriptor:_responseDescriptor];

}

@end
