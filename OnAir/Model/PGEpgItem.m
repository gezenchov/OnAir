//
//  PGEpgItem.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGEpgItem.h"

@implementation PGEpgItem


- (instancetype)init
{
    return [self initWithId:@"" name:NSLocalizedString(@"Unnamed", @"name default value") description:NSLocalizedString(@"No description", @"description default value") time:nil duration:@"0:00" presenter:@"" andBackgroundURL:nil];
}

- (instancetype)initWithId:(NSString*)anId name:(NSString*)aName description:(NSString*)aDescription time:(NSDate*)aTime duration:(NSString*)aDuration presenter:(NSString*)aPresenter andBackgroundURL:(NSURL*)aBackgroundURL
{
    if (self = [super init]) {
        _itemId = anId;
        _name = aName;
        _itemDescription = aDescription;
        _time = aTime;
        _duration = aDuration;
        _presenter = aPresenter;
        _backgroundURL = aBackgroundURL;
    }
    
    return self;
}


@end
