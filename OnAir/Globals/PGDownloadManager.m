//
//  PGDownloadManager.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGDownloadManager.h"
#import "PGServiceClient.h"

@implementation PGDownloadManager

+ (instancetype)sharedManager {
    static PGDownloadManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PGDownloadManager alloc] init];
        
    });
    
    return _sharedClient;
}

- (void)downloadOnAirDataWithSuccess:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    [[PGServiceClient sharedClient] GETRequestForResource:kOnAirData
                                               parameters:nil
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      success(responseObject);
                                                  }
                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      failure(error);
                                                  }];
}

@end
