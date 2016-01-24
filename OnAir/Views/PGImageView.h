//
//  PGImageView.h
//  PGExternal
//
//  Created by Petar Gezenchov on 15/08/14.
//  Copyright (c) 2014 com.gezenchov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PGImageHandler)(UIImage *loadedImage);


@interface PGImageView : UIImageView

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, copy) PGImageHandler imageLoadedHandler;

@end
