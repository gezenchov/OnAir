//
//  PGPageViewController.m
//  OnAir
//
//  Created by Petar Gezenchov on 16/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGPageViewController.h"
#import "PGPlayoutItem.h"

@interface PGPageViewController ()

@end

@implementation PGPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.detailsView.layer.cornerRadius = 12.0f;
    self.detailsView.layer.masksToBounds = YES;
    self.detailsView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.5f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PGPlayoutItem *item = self.dataObject;
    
    self.dataLabel.text = item.title;
    self.dataImage.imageURL = item.imageURL;
    self.artistLabel.text = item.artist;
    self.durationLabel.text = item.duration;
    self.albumLabel.text = item.album;
}

@end
