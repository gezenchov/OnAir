//
//  PGRootViewController.m
//  OnAir
//
//  Created by Petar Gezenchov on 16/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGRootViewController.h"
#import "PGPageModelController.h"
#import "PGPageViewController.h"
#import "PGPageContainerViewController.h"
#import "PGDataManager.h"
#import "PGOnAirData.h"
#import "PGEpgItem.h"

@interface PGRootViewController () <UIPageViewControllerDelegate> {
    BOOL _pulsingGlow;
}

@property (nonatomic, strong) PGPageContainerViewController *pageContainer;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (readonly, strong, nonatomic) PGPageModelController *modelController;
@property (nonatomic, strong) PGEpgItem *epgItem;

@property (nonatomic, weak) IBOutlet UIView *onAirView;
@property (nonatomic, weak) IBOutlet PGImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIView *getDataView;
@property (nonatomic, weak) IBOutlet UIView *buttonGlowView;
@property (nonatomic, weak) IBOutlet UIButton *button;


@end

@implementation PGRootViewController

static CGFloat const kInflateFromRatio = 1.1f;
static CGFloat const kInflateToRatio = 1.4f;
static CGFloat const kPageControllerTopMargin = 150.0f;

@synthesize modelController = _modelController;

#pragma mark - Accessor methods

- (PGPageModelController *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[PGPageModelController alloc] initWithPageViewController:self.pageViewController andStoryBoard:self.storyboard];
    }
    return _modelController;
}

- (UIPageViewController*)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }

    return _pageViewController;
}

#pragma mark - View Life Cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Setup on air view
    [self setupOnAirView];
    
    // Setup get data view and position off screen
    [self setupGetDataView];

    // Show button for loading images
    [self bringGetDataView];
}

#pragma mark - Setup methods

- (void)loadPageViewController
{
    self.pageContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContainerViewController"];
    
    self.pageViewController.delegate = self;
    
    PGPageViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self.modelController;
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    pageViewRect.origin.y = self.view.bounds.size.height;
    pageViewRect.size.height = self.view.bounds.size.height - kPageControllerTopMargin;
    self.pageContainer.view.frame = pageViewRect;
    self.pageViewController.view.frame = self.pageContainer.view.bounds;
    
    [self.pageContainer addChildViewController:self.pageViewController];
    [self.pageContainer.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self.pageContainer];
    
    [self addChildViewController:self.pageContainer];
    [self.view addSubview:self.pageContainer.view];
    [self.pageContainer didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)setupOnAirView
{
    // Position view above page controller header
    self.onAirView.frame = CGRectMake(0, 0, self.view.frame.size.width, kPageControllerTopMargin);
}

- (void)setupGetDataView
{
    // Get view size
    CGSize viewSize = self.view.bounds.size;
    
    // Position view off screen (bottom)
    CGRect frame = self.getDataView.frame;
    frame.origin.y = viewSize.height;
    frame.origin.x = (viewSize.width - frame.size.width) / 2;
    self.getDataView.frame = frame;
    
    self.button.layer.cornerRadius = self.button.frame.size.width / 2;
    self.button.layer.masksToBounds = YES;
    
    self.buttonGlowView.layer.cornerRadius = self.buttonGlowView.frame.size.width / 2;
    self.buttonGlowView.layer.masksToBounds = YES;
}



#pragma mark - Animation methods

- (void)bringGetDataView
{
    // Get view size
    CGSize viewSize = self.view.bounds.size;
    
    // Animate view appearence from bottom to the center of the screen
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(){
                         self.getDataView.center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
                     }completion:nil];
}

- (void)startLoadingPulsation
{
    _pulsingGlow = YES;
    
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(){
                         self.buttonGlowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, kInflateFromRatio, kInflateFromRatio);
                     }completion:^(BOOL finished){
                         [self glowInflate];
                     }];
}

- (void)stopPuslation
{
    _pulsingGlow = NO;
}

- (void)showGallery
{
    [self fillTopBar];
    [self showOnAirView];
    [self showPageViewController];
}

- (void)showOnAirView
{
    self.backgroundImage.alpha = 0.5f;
    self.backgroundImage.imageURL = self.epgItem.backgroundURL;
    self.nameLabel.text = self.epgItem.name;
    self.durationLabel.text = self.epgItem.duration;
    self.descriptionLabel.text = self.epgItem.itemDescription;
    
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(){
                         self.onAirView.alpha = 1.0f;
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)glowInflate
{
    if (_pulsingGlow) {
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^(){
                             self.buttonGlowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, kInflateToRatio, kInflateToRatio);
                         }completion:^(BOOL finished){
                             [self glowDefalte];
                         }];
    }
    else {
        [self showGallery];
    }
}

- (void)glowDefalte
{
    if (_pulsingGlow) {
        [UIView animateWithDuration:0.5f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^(){
                             self.buttonGlowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, kInflateFromRatio, kInflateFromRatio);
                         }completion:^(BOOL finished){
                             [self glowInflate];
                         }];
    }
    else {
        [self showGallery];
    }
}

- (void)fillTopBar
{
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(){
                         self.button.alpha = 0;
                     }completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:1.0f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(){
                         self.buttonGlowView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 10, 10);
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)showPageViewController
{
    CGRect frame = self.pageContainer.view.frame;
    frame.origin.y = kPageControllerTopMargin;
    
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(){
                         self.pageContainer.view.frame = frame;
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)scrollPages
{
    [self.modelController startAutoScroll];
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // Configure the page view controller and add it as a child view controller.
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - Action methods

- (IBAction)buttonPressed:(id)sender
{
    self.button.userInteractionEnabled = NO;
    [self startLoadingPulsation];
    
    [self.button setTitle:NSLocalizedString(@"LOADING", @"Button title") forState:UIControlStateNormal];
    
    [[PGDataManager sharedManager] getOnAirDataWithSuccess:^(NSArray *items){
        PGOnAirData *onAir = [items lastObject];
        self.epgItem = [onAir.egpDataItems lastObject];
        self.modelController.dataItems = onAir.playoutDataItems;
        
        [self stopPuslation];
        [self loadPageViewController];
        
        [self performSelector:@selector(scrollPages) withObject:nil afterDelay:2.0f];
    }failure:^(NSError *error){
        
    }];
    
}

@end
