//
//  PGDataManager.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGDataManager.h"
#import "PGServiceManager.h"
#import "PGOnAirMapper.h"

@implementation PGDataManager

+ (instancetype)sharedManager {
    static PGDataManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PGDataManager alloc] init];
        
    });
    
    return _sharedClient;
}

- (void)getOnAirDataWithSuccess:(void (^)(NSArray *playoutItems))success
                          failure:(void (^)(NSError *error))failure
{
    [[PGServiceManager sharedManager] downloadOnAirDataWithSuccess:^(id responseObject){
        [self mapPlayoutDataItems:responseObject succes:success failure:failure];
    }
                                                               failure:^(NSError *error){
                                                                   failure(error);
                                                               }];
}

- (void)mapPlayoutDataItems:(id)items succes:(void (^)(NSArray *playoutItems))success
                                            failure:(void (^)(NSError *error))failure
{
    PGOnAirMapper *mapper = [[PGOnAirMapper alloc] initWithParseObject:items
                                                               success:^(NSArray *items){
                                                                   success(items);
                                                               }
                                                               failure:^(NSError *error){
                                                                   failure(error);
                                                                   
                                                               }];
    [mapper parse];
}

@end
