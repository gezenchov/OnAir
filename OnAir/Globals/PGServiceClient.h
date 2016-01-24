//
//  PGServiceClient.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface PGServiceClient : NSObject

+ (instancetype)sharedClient;

- (void)GETRequestForResource:(NSString *)resourceName
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

extern NSString * const kOnAirData;

@end
