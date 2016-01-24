//
//  NSFileManager+DoNotBackup.h
//  PGExternal
//
//  Created by Petar Gezenchov on 15/08/14.
//  Copyright (c) 2014 com.gezenchov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (DoNotBackup)

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end
