//
//  PGEpgItem.h
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGEpgItem : NSObject


@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *presenter;
@property (nonatomic, strong) NSURL *backgroundURL;

- (instancetype)init;
- (instancetype)initWithId:(NSString*)anId
                      name:(NSString*)aName
               description:(NSString*)aDescription
                      time:(NSDate*)aTime
                  duration:(NSString*)aDuration
                 presenter:(NSString*)aPresenter
          andBackgroundURL:(NSURL*)aBackgroundURL;

@end
