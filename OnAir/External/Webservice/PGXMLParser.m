//
//  PGXMLParser.m
//  PGExternal
//
//  Created by Petar Gezenchov on 12/01/14.
//  Copyright (c) 2014 com.gezenchov. All rights reserved.
//

#import "PGXMLParser.h"

typedef void(^SuccessBlockType)(NSArray *items);
typedef void(^ErrorBlockType)(NSError *error);

@interface PGXMLParser() <NSXMLParserDelegate> {
    SuccessBlockType _success;
    ErrorBlockType _failure;
}

@property (nonatomic, strong) NSXMLParser *parser;

@end

@implementation PGXMLParser

#pragma mark -
#pragma mark Interface methods

- (instancetype)init
{
    return [self initWithParseObject:[NSXMLParser new]
                             success:nil
                             failure:nil];
}

- (instancetype)initWithParseObject:(NSXMLParser *)aParser success:(void (^)(NSArray *))aSuccess failure:(void (^)(NSError *))aFailure
{
    if (self = [super init]) {
        _parser = aParser;
        _success = aSuccess;
        _failure = aFailure;
        _items = [NSMutableArray new];
    }
    
    return self;
}

- (void)parse
{
    [self parse:self.parser];
}

- (void)parse:(NSXMLParser*)parser
{
    // set self as parser delegate to handle parser events
    [parser setDelegate:self];
    // start parsing process
    [parser parse];
}

//================================================================
#pragma mark NSXMLParserDelegate Methods
//================================================================

// function that is called when tag with name "elementName" is found
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSString * selectorName = elementName;
    selectorName = [selectorName stringByAppendingString:@":"];
    
    SEL _tagSelector = NSSelectorFromString(selectorName);
    
    if([self respondsToSelector:_tagSelector])
    {
        ((void (*)(id, SEL, id))[self methodForSelector:_tagSelector])(self, _tagSelector, attributeDict);
        _tagSelector=nil;
    }
}

// function is called when error message occured
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    _failure(parseError);
}

// function is called when parser did end dociment parsing
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    _success(self.items);
}

@end
