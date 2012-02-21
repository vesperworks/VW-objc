//
//  NSObject+VWBlocks.h
//
//  Created by vesperworks on 11/12/12.
//  Copyright (c) 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (VWBlocks)
- (void)performBlock: ( void (^)() ) block;
- (void)performBlock: ( void (^)() ) block afterDelay: (NSTimeInterval) delay;
@end