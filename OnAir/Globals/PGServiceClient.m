//
//  PGServiceClient.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGServiceClient.h"
#import "AFHTTPRequestOperationManager.h"

@interface PGServiceClient () {
    // responsible for managing operations
    AFHTTPRequestOperationManager *_requestManager;
}

@end

@implementation PGServiceClient

static NSString * const kPGNetworkServiceAPIURLString  = @"http://apps.aim-data.com/";

#pragma mark - Constructor

- (id)init
{
    self = [super init];
    if (self) {
        [self setupRequestManagerForBaseURL:[NSURL URLWithString:kPGNetworkServiceAPIURLString]];
    }
    
    return self;
}


#pragma mark - Public Methods

+ (instancetype)sharedClient {
    static PGServiceClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PGServiceClient alloc] init];
        
    });
    
    return _sharedClient;
}

- (void)GETRequestForResource:(NSString *)resourceName
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [_requestManager GET:[NSString stringWithFormat:@"data/abc/triplej/%@", resourceName]
              parameters:parameters success:success failure:failure];
}

#pragma mark - Private methods

- (void)setupRequestManagerForBaseURL:(NSURL *)baseURL
{
    _requestManager                     = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    _requestManager.requestSerializer   = [[AFHTTPRequestSerializer alloc] init];
    _requestManager.responseSerializer  = [[AFXMLParserResponseSerializer alloc] init];
    
    [_requestManager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    
    NSURL *googleURL = [NSURL URLWithString:@"http://google.com"];
    _requestManager.reachabilityManager = [AFNetworkReachabilityManager managerForDomain:googleURL.host];
    
    [_requestManager.reachabilityManager startMonitoring];
}

@end

NSString * const kOnAirData = @"onair.xml";