//
//  PGPageViewController.h
//  OnAir
//
//  Created by Petar Gezenchov on 16/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGImageView.h"

@interface PGPageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet PGImageView *dataImage;
@property (strong, nonatomic) IBOutlet UIView *detailsView;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumLabel;

@property (strong, nonatomic) id dataObject;

@end

