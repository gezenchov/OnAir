//
//  PGApplicationManager.m
//  OnAir
//
//  Created by Petar Gezenchov on 24/01/2016.
//  Copyright © 2016 com.gezenchov. All rights reserved.
//

#import "PGApplicationManager.h"

@implementation PGApplicationManager

+ (PGApplicationManager *)shared
{
    static PGApplicationManager *_sharedApplicationManager = nil;
    static dispatch_once_t oncePredicateCacheController;
    dispatch_once(&oncePredicateCacheController,
                  ^{
                      _sharedApplicationManager = [PGApplicationManager new];
                  });
    
    return _sharedApplicationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serviceManager         = [PGServiceManager new];
        _dataManager            = [PGDataManager new];
    }
    return self;
}

@end
