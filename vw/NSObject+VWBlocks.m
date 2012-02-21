//
//  NSObject+VWBlocks.m
//
//  Created by vesperworks on 11/12/12.
//  Copyright (c) 2011 vesperworks. All rights reserved.
//

#import "NSObject+VWBlocks.h"

@implementation NSObject (VWBlocks)

- (void)performBlock: ( void (^)() ) block {
	block();
}

- (void)performBlock: ( void (^)() ) block afterDelay: (NSTimeInterval) delay {
	[self performSelector: @selector(performBlock:) withObject: [[block copy] autorelease] afterDelay: delay];
}

@end