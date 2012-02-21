//
//  VWFileManager.h
//
//  Created by vesperworks on 11/09/01.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWFileManager : NSObject

+ (VWFileManager *)sharedInstance;

- (id)loadWithDatName: (NSString *) datName;
- (void)saveWithDatName: (NSString *) datName andData: (id) data;
- (void)removeWithDatName: (NSString *) datName;
- (BOOL)isExistFileWithDatName: (NSString *) datName;
@end