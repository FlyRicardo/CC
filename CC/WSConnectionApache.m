//
//  WSConnection.m
//  CC
//
//  Created by Fly on 11/26/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "WSConnectionApache.h"

@implementation WSConnectionApache{
    NSString *baseUrl;
    AFHTTPClient *client;
}

+(id)sharedWSConnectionApache{
    static WSConnectionApache *sharedWSConnectionApache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedWSConnectionApache = [[self alloc]init];});
    return sharedWSConnectionApache;
}

-(id)init{
    
    /**Configuration baseUrl to flyinc.co**/
//    baseUrl = @"http://www.flyinc.co";
    
    /**Configuration baseUrl to localhost:82**/
    baseUrl = @"http://127.0.0.1:82";
    
   return [self initWithBaseUrl:baseUrl];
    
}

-(id) initWithBaseUrl:(NSString *)url{
    if (self = [super init]) {
        
        // setup object mappings
        NSURL *baseURL = [NSURL URLWithString:url];
        client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        
        _objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
    }
    return self;
}

@end
