//
//  PGImageView.m
//  PGExternal
//
//  Created by Petar Gezenchov on 15/08/14.
//  Copyright (c) 2014 com.gezenchov. All rights reserved.
//

#import "PGImageView.h"

#import "NSFileManager+DoNotBackup.h"

@interface PGImageView (){
    NSString *_loadingURL;
}

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;

@end

@implementation PGImageView

static NSString *documentsDirectory;
static NSCharacterSet *nonAlphaNumericalSet;
static NSMutableDictionary *PGImageViewCache;

#pragma mark - Accessor methods

- (void)setImageURL:(NSURL *)url
{
    [self setImageFromURL:url];
}

- (NSURL*)imageURL
{
    return self.URL;
}

-(void)setImage:(UIImage *)image{
    if (!image) {// If no image loaded add activity indicator
        [self addLoadingToView];
    }
    else {// If valid image passed remove activity indicator
        [self.loadingIndicator removeFromSuperview];
    }
    
    __block UIImage *blockImage = image;
    
    BOOL shouldChange = (image != self.image);
    if(shouldChange){// If changing image perform transition
        // Check if current image is blank
        BOOL updatingBlankImage = !self.image;
        
        [super setImage:blockImage];
        
        if (updatingBlankImage) {// If updating from a blank image perfom a fade transition
            CATransition *transition = [CATransition animation];
            transition.duration = 0.5f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            
            [self.layer addAnimation:transition forKey:nil];
        }
        
        if(self.imageLoadedHandler){// Execute completion block handler if assigned
            self.imageLoadedHandler(blockImage);
        }
    }
}


-(void)setImageFromURL:(id)anURL{
    // Check if passed URL is string. If so - convert to URL
    if([anURL isKindOfClass:[NSString class]]){
        while ([anURL hasPrefix:@" "]) {
            anURL = [anURL substringFromIndex:1];
        }
        
        anURL = [NSURL URLWithString:[anURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    self.URL = anURL;
    
    if(!PGImageViewCache){// Create cache if not present
        PGImageViewCache = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    NSString *thisURL = [anURL absoluteString];
    @synchronized(self){
        _loadingURL = thisURL;
    }
    
    // Check if image is cached
    UIImage *image = [PGImageViewCache objectForKey:anURL];
    
    if(!image){// If not cached check persistent cache (file system)
        image = [PGImageView storedImageForURL:[anURL absoluteString]];
        if(!image){ // Not found on persistent cache too - we need to download the image
            // Setup view for downloading image
            [self addLoadingToView];
            self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.2];
            // Async download file
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0L), ^{
                NSError* error = nil;
                NSData* data = [NSData dataWithContentsOfURL:anURL options:NSDataReadingUncached error:&error];
                __block UIImage *downloadedImage = [UIImage imageWithData:data];
                if(downloadedImage){
                    // Store to documents
                    [PGImageView storeImage:downloadedImage forURL:anURL];
                    
                    BOOL updateImageView = NO;
                    @synchronized(PGImageViewCache){
                        // Load in cache
                        [PGImageViewCache setObject:downloadedImage forKey:anURL];
                    }
                    
                    @synchronized(self){
                        if([thisURL isEqualToString:_loadingURL]){
                            updateImageView = YES;
                        }
                    }
                    
                    // Update image in main thread
                    if(updateImageView){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            downloadedImage = [UIImage imageWithCGImage:downloadedImage.CGImage scale:2 orientation:image.imageOrientation];
                            [self setImage:downloadedImage];
                            
                            // Execute compeletion handler if assigned
                            if(self.imageLoadedHandler){
                                self.imageLoadedHandler(downloadedImage);
                            }
                        });
                    }
                }
            });
        }
        else{
            // Loaded from persistent cache (file system)
            image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:image.imageOrientation];
            [self setImage:image];
            
            if(self.imageLoadedHandler){
                self.imageLoadedHandler(image);
            }
        }
    }
    else{
        // Loaded from memory cache (RAM)
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:image.imageOrientation];
        [self setImage:image];
        
        if(self.imageLoadedHandler){
            self.imageLoadedHandler(image);
        }
    }
}

- (void)addLoadingToView
{
    // Avoid duplication UIActivityIndicator
    if (self.loadingIndicator) {
        [self.loadingIndicator removeFromSuperview];
    }
    
    CGFloat loadingSize = 25.0f;
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width - loadingSize) / 2, (self.frame.size.height - loadingSize) / 2, loadingSize, loadingSize)];
    self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.loadingIndicator.color = [UIColor darkGrayColor];
    
    [self.loadingIndicator startAnimating];
    [self addSubview:self.loadingIndicator];
}

-(void)didReceiveMemoryWarning:(NSNotification*)notification{
    [PGImageViewCache removeAllObjects];
}

#pragma mark - Static utility methods

+ (NSString *)documentsDirectory
{
    if(!documentsDirectory){
        documentsDirectory = ((NSURL*)[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                        inDomains:NSUserDomainMask] lastObject]).path;
    }
    
    return documentsDirectory;
}

+ (NSCharacterSet*)nonAlphaNumericalCharacterSet
{
    if(!nonAlphaNumericalSet){
        nonAlphaNumericalSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    }
    
    return nonAlphaNumericalSet;
}

+ (UIImage*)storedImageForURL:(id)url
{
    // Accept both NSString and NSURL, convert URL to string if required
    if([url isKindOfClass:[NSURL class]]){
        url = [url absoluteString];
    }
    NSString *path = [url stringByTrimmingCharactersInSet:[PGImageView nonAlphaNumericalCharacterSet]];
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    path = [path stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    path = [NSString stringWithFormat:@"PGImageViewCache_%@", path];
    NSString *fullPath = [[PGImageView documentsDirectory] stringByAppendingPathComponent:path];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

+ (void)storeImage:(UIImage*)img forURL:(id)url
{
    // Accept both NSString and NSURL, convert string to URL if required
    if([url isKindOfClass:[NSString class]]){
        url = [NSURL URLWithString:url];
    }
    
    NSString *path = [url absoluteString];
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    path = [path stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    path = [NSString stringWithFormat:@"PGImageViewCache_%@", path];
    path = [path stringByTrimmingCharactersInSet:[PGImageView nonAlphaNumericalCharacterSet]];
    
    NSString *fullPath = [[PGImageView documentsDirectory] stringByAppendingPathComponent:path];
    // Cache response but prevent it to be backup
    [UIImageJPEGRepresentation(img, 0.9) writeToFile:fullPath atomically:NO];
    [[NSFileManager defaultManager] addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:fullPath]];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
