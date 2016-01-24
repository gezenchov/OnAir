//
//  PGPlayoutItem.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGPlayoutItem.h"

@implementation PGPlayoutItem


- (instancetype)init
{
    return [self initWithTime:nil duration:@"0:00" title:NSLocalizedString(@"Unknown", @"no title value") artist:NSLocalizedString(@"Unknown", @"no artist value") album:NSLocalizedString(@"Unknown", @"no album value") status:PlayoutItemStatusNone type:PlayoutItemTypeNone andImageURL:nil];
}

- (instancetype)initWithTime:(NSDate*)aTime duration:(NSString*)aDuration title:(NSString*)aTitle artist:(NSString*)anArtist album:(NSString*)anAlbum status:(PlayoutItemStatus)aStatus type:(PlayoutItemType)aType andImageURL:(NSURL *)anImageURL
{
    if (self = [super init]) {
        _time = aTime;
        _duration = aDuration;
        _title = aTitle;
        _artist = anArtist;
        _album = anAlbum;
        _status = aStatus;
        _type = aType;
        _imageURL = anImageURL;
    }
    
    return self;
}


@end
