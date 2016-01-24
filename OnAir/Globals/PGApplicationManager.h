//
//  PGApplicationManager.h
//  OnAir
//
//  Created by Petar Gezenchov on 24/01/2016.
//  Copyright © 2016 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGServiceManager.h"
#import "PGDataManager.h"

@interface PGApplicationManager : NSObject

@property (nonatomic, strong, readonly) PGDataManager       *dataManager;
@property (nonatomic, strong, readonly) PGServiceManager    *serviceManager;

/**
 *  Shared instance of PGApplicationManager which gives access to all manager classes that must have only 1 instance.
 *
 *  @return Shared instance
 */
+ (PGApplicationManager *)shared;

@end
