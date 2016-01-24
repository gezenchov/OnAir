//
//  PGPlayoutItem.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PlayoutItemTypeNone,
    PlayoutItemTypeSong
} PlayoutItemType;

typedef enum : NSUInteger {
    PlayoutItemStatusNone,
    PlayoutItemStatusPlaying,
    PlayoutItemStatusHistory
} PlayoutItemStatus;


@interface PGPlayoutItem : NSObject

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *album;
@property (nonatomic) PlayoutItemStatus status;
@property (nonatomic) PlayoutItemType type;
@property (nonatomic, strong) NSURL *imageURL;

- (instancetype)init;
- (instancetype)initWithTime:(NSDate*)aTime
                    duration:(NSString*)aDuration
                       title:(NSString*)aTitle
                      artist:(NSString*)anArtist
                       album:(NSString*)anAlbum
                      status:(PlayoutItemStatus)aStatus
                        type:(PlayoutItemType)aType
                 andImageURL:(NSURL*)anImageURL;


@end
