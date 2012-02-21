//
//  VWColorUtil.m
//
//  Created by vesperworks on 11/10/21.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import "VWColorUtil.h"

@implementation VWColorUtil
static VWColorUtil *_sharedInstance = nil;

+ (VWColorUtil *)sharedInstance {
	if (!_sharedInstance) {
		_sharedInstance = [[VWColorUtil alloc] init];
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

- (UIColor *)getUIColorWithHex: (int) hex {
	return [UIColor colorWithRed: ( (hex >> 16) & 0xFF ) / 255.0 green: ( (hex >> 8) & 0xFF ) / 255.0 blue: (hex & 0xFF) / 255.0 alpha: 1.0];
}

@end