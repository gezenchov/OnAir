//
//  PGPageContainerViewController.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGPageContainerViewController.h"
#import "PGHeaderView.h"

@interface PGPageContainerViewController ()

@property (nonatomic, weak) IBOutlet PGHeaderView *headerView;
@property (nonatomic, weak) IBOutlet UIView *topGradientView;

@end

@implementation PGPageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    topGradient.frame = self.topGradientView.bounds;
    topGradient.backgroundColor = [UIColor clearColor].CGColor;
    topGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor lightGrayColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [self.topGradientView.layer insertSublayer:topGradient atIndex:0];

}

@end
