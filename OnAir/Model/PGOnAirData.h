//
//  PGOnAirObject.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGOnAirData : NSObject

@property (nonatomic, strong) NSMutableArray *egpDataItems;
@property (nonatomic, strong) NSMutableArray *playoutDataItems;

- (instancetype)init;
- (instancetype)initWithEgpDataItems:(NSArray*)anEpgDataItems andPlayoutDataItems:(NSArray*)aplayoutDataItems;

@end
