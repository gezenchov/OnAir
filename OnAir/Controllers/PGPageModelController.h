//
//  PGPageModelController.h
//  OnAir
//
//  Created by Petar Gezenchov on 16/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGPageViewController;

@interface PGPageModelController : NSObject <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIStoryboard *storyboard;
@property (nonatomic, strong) NSArray *dataItems;

- (instancetype)init;
- (instancetype)initWithPageViewController:(UIPageViewController*)aPageViewController andStoryBoard:(UIStoryboard*)aStoryboard;

- (PGPageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PGPageViewController *)viewController;
- (void)startAutoScroll;

@end

