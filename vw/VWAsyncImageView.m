//
//  AsyncImageView.m
//
//  Created by vesperworks on 11/06/14.
//  Copyright 2011 vesperworks. All rights reserved.
//
//

#import "VWAsyncImageView.h"


@interface VWAsyncImageView (private)

- (void)_showSpiner;
- (void)_hideSpiner;
- (void)_startShowAnimation;

@end

@implementation VWAsyncImageView

//--------------------------------------------------------------//
#pragma mark -- initializer --
//--------------------------------------------------------------//

- (void)dealloc {
	[self cancel];
	[refreshSpinner release], refreshSpinner = nil;
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
	self.alpha = 0.0;

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
	[self cancel];
	self.image = nil;

	self.backgroundColor = (color) ? color : [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0];
	data = [[NSMutableData alloc] initWithCapacity: 0];

	NSURLRequest *req = [NSURLRequest
	                     requestWithURL: [NSURL URLWithString: url]
	                     cachePolicy: NSURLRequestUseProtocolCachePolicy
	                     timeoutInterval: 30.0];
	conn = [[NSURLConnection alloc] initWithRequest: req delegate: self startImmediately: NO];

	[conn scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode: NSRunLoopCommonModes];
	[conn start];

	[self _showSpiner];
}

- (void)cancel {
	[self _hideSpiner];

	if (conn != nil) {
		[conn cancel], [conn release], conn = nil;
	}
	if (data != nil) {
		[data release], data = nil;
	}
}

//--------------------------------------------------------------//
#pragma mark -- NSURLConnection delegate --
//--------------------------------------------------------------//

- (void)connection: (NSURLConnection *) connection didReceiveResponse: (NSURLResponse *) response {
	[data setLength: 0];
}

- (void)connection: (NSURLConnection *) connection didReceiveData: (NSData *) nsdata {
	[data appendData: nsdata];
}

- (void)connection: (NSURLConnection *) connection didFailWithError: (NSError *) error {
	[self cancel];
}

- (void)connectionDidFinishLoading: (NSURLConnection *) connection {
	UIImage *image = [UIImage imageWithData: data];
	self.image = image;

	self.contentMode = UIViewContentModeScaleAspectFill;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	[self _startShowAnimation];

	[self cancel];
}

@end