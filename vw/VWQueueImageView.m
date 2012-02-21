//
//  VWQueueImageView.m
//
//  Created by vesperworks on 11/10/25.
//  Copyright 2011 vesperworks. All rights reserved.
//
#import "VWQueueImageView.h"
#import "VWUrlConectOperation.h"


@interface VWQueueImageView (private)

- (void)_showSpiner;
- (void)_hideSpiner;
- (void)_startShowAnimation;

@end


@implementation VWQueueImageView

//--------------------------------------------------------------//
#pragma mark -- initializer --
//--------------------------------------------------------------//

static NSOperationQueue * sharedQueue = nil;
static NSCache *sharedImgCache = nil;


@synthesize delegate;
@synthesize latestURL;

+ (NSOperationQueue *)sharedImgOperationQueue {
	if (sharedQueue == nil) {
		sharedQueue = [[NSOperationQueue alloc] init];
		[sharedQueue setMaxConcurrentOperationCount: 3];
	}
	return sharedQueue;
}

+ (NSCache *)sharedImgCache {
	if (sharedImgCache == nil) {
		sharedImgCache = [[NSCache alloc] init];
	}
	return sharedImgCache;
}

- (void)dealloc {
	[super dealloc];
}

//--------------------------------------------------------------//
#pragma mark -- private method --
//--------------------------------------------------------------//

- (void)_showSpiner {
	refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
	refreshSpinner.frame = CGRectMake(self.frame.size.width / 2 - 10, self.frame.size.height / 2 - 10, 20, 20);
	refreshSpinner.hidesWhenStopped = YES;

	[refreshSpinner startAnimating];

	[self addSubview: refreshSpinner];
}

- (void)_hideSpiner {
	[refreshSpinner stopAnimating];

	[refreshSpinner removeFromSuperview];
	refreshSpinner = nil;
}

- (void)_startShowAnimation {

	[self setAlpha: 0.0];

	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations: nil context: context];
	[UIView setAnimationDuration: 0.2];

	[self setAlpha: 1.0];

	[UIView commitAnimations];
}

//--------------------------------------------------------------//
#pragma mark -- public --
//--------------------------------------------------------------//

- (void)loadImageURL: (NSString *) url withCollor: (UIColor *) color {
	
	self.latestURL = url;

	self.image = nil;
	
	[self _hideSpiner];

	UIImage *image = [[VWQueueImageView sharedImgCache] objectForKey: url];

	if (image != nil) {
		self.image = image;
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}
	else {
		VWUrlConectOperation *operation = [[VWUrlConectOperation alloc] initWithURL: url];
		[operation addObserver: self forKeyPath: @"isFinished" options: NSKeyValueObservingOptionNew context: nil];
		[[VWQueueImageView sharedImgOperationQueue] addOperation: operation];
		[operation release];

		[self _showSpiner];
	}
}

//--------------------------------------------------------------//
#pragma mark -- KVO --
//--------------------------------------------------------------//

- (void)observeValueForKeyPath: (NSString *) keyPath ofObject: (id) object change: (NSDictionary *) change context: (void *) context {
	VWUrlConectOperation *operation = object;
	[operation removeObserver: self forKeyPath: @"isFinished"];

	UIImage *image = [UIImage imageWithData: operation.response];

	if (image) {
		[[VWQueueImageView sharedImgCache] setObject: image forKey: operation.url];
	}

	if (self.latestURL == operation.url) {
		self.image = image;
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

		[self performSelectorOnMainThread:@selector(_startShowAnimation) withObject:nil waitUntilDone:YES];
//		[self _startShowAnimation];

		[self _hideSpiner];
	}
}

@end