//
//  VWQueue.m
//
//  Created by vesperworks on 11/10/17.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import "VWQueue.h"

@implementation VWQueue

@synthesize count = _count;
@synthesize queue = _queue;

//--------------------------------------------------------------//
#pragma mark -- initializer --
//--------------------------------------------------------------//

- (id)initWithSize: (int) aMaxSize {
	self = [super init];
	if (self != nil) {
		_queue = [[NSMutableArray alloc] init];
		_maxSize = aMaxSize;
	}
	return self;
}

//--------------------------------------------------------------//
#pragma mark -- public function --
//--------------------------------------------------------------//

- (id)dequeue {
	if ([_queue count] == 0) return nil;
	id headObject = [_queue objectAtIndex: 0];

	if (headObject != nil) {
		[[headObject retain] autorelease];
		[_queue removeObjectAtIndex: 0];
	}

	return headObject;
}

- (void)enqueue: (id) anObject {
	if (anObject == nil) {
		return;
	}
	if ([_queue count] >= _maxSize) {
		[_queue removeObjectAtIndex: 0];
	}
	[_queue addObject: anObject];
}

- (int)count {
	int c = 0;
	c = [_queue count];

	return c;
}

@end