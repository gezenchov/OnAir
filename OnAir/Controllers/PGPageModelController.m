//
//  PGPageModelController.m
//  OnAir
//
//  Created by Petar Gezenchov on 16/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGPageModelController.h"
#import "PGPageViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface PGPageModelController () {
    NSInteger _autoScrollIndex;
    BOOL _userDidScroll;
}

@end

@implementation PGPageModelController


- (instancetype)init
{
    return [self initWithPageViewController:[UIPageViewController new] andStoryBoard:[UIStoryboard new]];
}
- (instancetype)initWithPageViewController:(UIPageViewController*)aPageViewController andStoryBoard:(UIStoryboard*)aStoryboard
{
    if (self = [super init]) {
        _pageViewController = aPageViewController;
        _storyboard = aStoryboard;
    }
    
    return self;
}

#pragma mark - Public methods

- (void)startAutoScroll
{
    if (!_userDidScroll) {
        [self incrementPageScrollIndex];
        
        PGPageViewController *firstViewController = [self viewControllerAtIndex:_autoScrollIndex storyboard:self.storyboard];
        
        //  Set up the array that holds these guys...
        
        NSArray *viewControllers = nil;
        
        viewControllers = [NSArray arrayWithObjects:firstViewController, nil];
        
        //  Now, tell the pageViewContoller to accept these guys and do the forward turn of the page.
        //  Again, forward is subjective - you could go backward.  Animation is optional but it's
        //  a nice effect for your audience.
        
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        [self performSelector:@selector(startAutoScroll) withObject:nil afterDelay:6.0f];
    }
}

- (void)incrementPageScrollIndex
{
    if ((self.dataItems.count - 2) > _autoScrollIndex) {
        _autoScrollIndex++;
    }
    else {
        _autoScrollIndex = 0;
    }
}

- (PGPageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([self.dataItems count] == 0) || (index >= [self.dataItems count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    PGPageViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.dataItems[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(PGPageViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.dataItems indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    _userDidScroll = YES;
    
    NSUInteger index = [self indexOfViewController:(PGPageViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    _userDidScroll = YES;
    
    NSUInteger index = [self indexOfViewController:(PGPageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.dataItems count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
