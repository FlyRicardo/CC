//
//  WebServicePromotionList.h
//  CC
//
//  Created by Fly on 11/26/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServicePromotionListPrt
-(NSArray *)getPromotionList;
@end

@interface WebServicePromotionList : NSObject
-(NSArray *)getPromotionList;
@end
