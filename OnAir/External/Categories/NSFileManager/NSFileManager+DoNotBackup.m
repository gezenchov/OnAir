//
//  NSFileManager+DoNotBackup.m
//  PGExternal
//
//  Created by Petar Gezenchov on 15/08/14.
//  Copyright (c) 2014 com.gezenchov. All rights reserved.
//

#import "NSFileManager+DoNotBackup.h"

#include <sys/xattr.h>

@implementation NSFileManager (DoNotBackup)

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSError *error = nil;
    [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    return error == nil;
}

@end
