//
//  NSMutableArray+VWDequeAddition.m
//
//  Created by vesperworks on 11/10/18.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import "NSMutableArray+VWDequeAddition.h"

@implementation NSMutableArray (VWDequeAddition)

- (id)pop {
	id lastObject = [[[self lastObject] retain] autorelease];
	if (lastObject)
		[self removeLastObject];
	return lastObject;
}

- (id)shift {
	id firstObject = [[[self objectAtIndex: 0] retain] autorelease];
	if (firstObject)
		[self removeObjectAtIndex: 0];
	return firstObject;
}

- (void)push: (id) obj {
	[self addObject: obj];
}

- (void)unshift: (id) obj {
	[self insertObject: obj atIndex: 0];
}

@end