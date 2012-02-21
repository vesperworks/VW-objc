//
//  VWUrlConectOperation.m
//
//  Created by vesperworks on 11/11/02.
//  Copyright (c) 2011 vesperworks. All rights reserved.
//

#import "VWUrlConectOperation.h"

@implementation VWUrlConectOperation

@synthesize response;
@synthesize url;

//--------------------------------------------------------------//
#pragma mark -- Initialize --
//--------------------------------------------------------------//
- (id)initWithURL: (NSString *) targetUrl {
	self = [super init];
	if (self) {
		self.url = targetUrl;
		_isExecuting = NO;
		_isFinished = NO;
		_isCancelled = NO;
	}

	return self;
}

- (void)dealloc {
	self.url = nil;
	self.response = nil;
	[super dealloc];
}

- (void)start {
//	if (![NSThread isMainThread]) {
//		[self performSelectorOnMainThread: @selector(start) withObject: nil waitUntilDone: NO];
//		return;
//	}

	if (![self isCancelled]) {
		[self willChangeValueForKey: @"isExecuting"];
		_isExecuting = YES;
		[self didChangeValueForKey: @"isExecuting"];

		connection = [[NSURLConnection alloc] initWithRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: self.url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 30.0] delegate: self startImmediately: YES];

		if (connection) {
			responseData = [[NSMutableData alloc] init];
			do {
				[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
			} while (_isExecuting);

		}
		else {
			//[self finish];
		}
	}
}

- (void)finish {
	connection = nil;

	responseData = nil;

	[self willChangeValueForKey: @"isExecuting"];
	[self willChangeValueForKey: @"isFinished"];

	_isExecuting = NO;
	_isFinished = YES;

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
	[self didChangeValueForKey: @"isExecuting"];
	[self didChangeValueForKey: @"isFinished"];
}

- (void)cancel {
	[self willChangeValueForKey: @"isCancelled"];

	[connection cancel];
	_isCancelled = YES;

	[self didChangeValueForKey: @"isCancelled"];

	[self finish];
}

- (BOOL)isExecuting {
	return _isExecuting;
}

- (BOOL)isFinished {
	return _isFinished;
}

- (BOOL)isCancelled {
	return _isCancelled;
}

- (BOOL)isConcurrent {
	return YES;
}

//--------------------------------------------------------------//
#pragma mark -- NSUrlConnection delegate --
//--------------------------------------------------------------//


- (void)connection: (NSURLConnection *) connection didReceiveResponse: (NSURLResponse *) response {
	responseData = [[NSMutableData alloc] init];
}

- (void)connection: (NSURLConnection *) connection didReceiveData: (NSData *) data {
	[responseData appendData: data];
}

- (void)connectionDidFinishLoading: (NSURLConnection *) connection {
	self.response = responseData;
	[responseData release];
	[self finish];
}

@end