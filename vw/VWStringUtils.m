//
//  VWStringUtils.m
//
//  Created by vesperworks on 11/11/11.
//  Copyright (c) 2011 vesperworks. All rights reserved.
//

#import "VWStringUtils.h"

@implementation VWStringUtils
static VWStringUtils *_sharedInstance = nil;

+ (VWStringUtils *)sharedInstance {
	if (!_sharedInstance) {
		_sharedInstance = [[VWStringUtils alloc] init];
	}

	return _sharedInstance;
}

- (id)init {
	self = [super init];
	if (self) {
		_sharedInstance = self;
	}

	return _sharedInstance;
}

- (void)dealloc {

    [super dealloc];
}

- (NSString *)urlEncodeWithString: (NSString *) string {
	return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

- (NSString *)urlDecodeWithURL: (NSString *) string {
	return (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(CFStringRef)string,CFSTR(""),kCFStringEncodingUTF8);
}

@end