//
//  PGOnAirMapper.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGOnAirMapper.h"
#import "PGOnAirData.h"
#import "PGEpgItem.h"
#import "PGPlayoutItem.h"

@interface PGOnAirMapper()

@property (nonatomic,strong) NSMutableArray *result;
@property (nonatomic, strong) NSXMLParser *data;

@end

@implementation PGOnAirMapper

- (void)onAir:(NSDictionary*)content
{
    self.onAirData = [[PGOnAirData alloc] init];
    [self.items addObject:self.onAirData];
}

- (void)epgItem:(NSDictionary*)content
{
    NSDate *date = [NSDate new];
    PGEpgItem *item = [[PGEpgItem alloc] initWithId:[content objectForKey:@"id"]
                                               name:[content objectForKey:@"name"]
                                        description:[content objectForKey:@"description"]
                                               time:date
                                           duration:[content objectForKey:@"duration"]
                                          presenter:[content objectForKey:@"presenter"]
                                   andBackgroundURL:[NSURL URLWithString:[content objectForKey:@""]]];
    
    [self.onAirData.egpDataItems addObject:item];
}

- (void)customField:(NSDictionary*)content
{
    if ([[content valueForKey:@"name"] isEqualToString:@"image640"]) {
        ((PGEpgItem*)[self.onAirData.egpDataItems lastObject]).backgroundURL = [NSURL URLWithString:[content valueForKey:@"value"]];
    }
}

- (void)playoutItem:(NSDictionary*)content
{
    NSDate *date = [NSDate new];
    PGPlayoutItem *item = [[PGPlayoutItem alloc] initWithTime:date
                                                     duration:[content objectForKey:@"duration"]
                                                        title:[content objectForKey:@"title"]
                                                       artist:[content objectForKey:@"artist"]
                                                        album:[content objectForKey:@"album"]
                                                       status:((NSString*)[content valueForKey:@"status"]).integerValue
                                                         type:((NSString*)[content valueForKey:@"type"]).integerValue
                                                  andImageURL:[NSURL URLWithString:[content valueForKey:@"imageUrl"]]];
    
    [self.onAirData.playoutDataItems addObject:item];
}

@end