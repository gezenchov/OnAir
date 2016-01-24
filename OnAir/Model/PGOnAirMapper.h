//
//  PGOnAirMapper.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGXMLParser.h"
#import "PGOnAirData.h"

@interface PGOnAirMapper : PGXMLParser

@property (nonatomic, strong) PGOnAirData *onAirData;

@end