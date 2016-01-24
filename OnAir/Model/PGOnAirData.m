//
//  PGOnAirObject.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGOnAirData.h"

@implementation PGOnAirData

- (instancetype)init
{
    return [self initWithEgpDataItems:[NSArray new] andPlayoutDataItems:[NSArray new]];
}

- (instancetype)initWithEgpDataItems:(NSArray*)anEpgDataItems andPlayoutDataItems:(NSArray*)aplayoutDataItems
{
    if (self = [super init]) {
        _egpDataItems = [[NSMutableArray alloc] initWithArray:anEpgDataItems];
        _playoutDataItems = [[NSMutableArray alloc] initWithArray:aplayoutDataItems];
    }
    
    return self;
}

@end
