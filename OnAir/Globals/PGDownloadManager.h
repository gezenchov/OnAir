//
//  PGDownloadManager.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGDownloadManager : NSObject

+ (instancetype)sharedManager;

- (void)downloadOnAirDataWithSuccess:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

@end
