//
//  VWStringUtils.h
//
//  Created by vesperworks on 11/11/11.
//  Copyright (c) 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWStringUtils : NSOperation
+ (VWStringUtils *)sharedInstance;

- (NSString *)urlEncodeWithString: (NSString *) string;
- (NSString *)urlDecodeWithURL: (NSString *) string;
@end