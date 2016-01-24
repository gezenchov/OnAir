//
//  PGXMLParser.h
//  PGExternal
//
//  Created by Petar Gezenchov on 12/01/14.
//  Copyright (c) 2014 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGXMLParser : NSObject

@property (nonatomic, strong) NSMutableArray *items;

- (instancetype)init;
- (instancetype)initWithParseObject:(NSXMLParser*)aParser
                            success:(void (^)(NSArray *items))aSuccess
                            failure:(void (^)(NSError *error))aFailure;

- (void)parse;

@end
