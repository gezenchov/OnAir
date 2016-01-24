//
//  PGDataManager.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGDataManager : NSObject

+ (instancetype)sharedManager;

- (void)getOnAirDataWithSuccess:(void (^)(NSArray *playoutItems))success
                          failure:(void (^)(NSError *error))failure;


@end
