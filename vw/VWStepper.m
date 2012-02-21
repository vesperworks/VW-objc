//
//  VWStepper.m
//
//  Created by vesperworks on 11/10/16.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import "VWStepper.h"

@implementation VWStepper

@synthesize CHANGED = _CHANGED;
@synthesize NEXT = _NEXT;
@synthesize PREV = _PREV;
@synthesize IS_MAX = _IS_MAX;
@synthesize IS_MIN = _IS_MIN;

@synthesize delegate;

@synthesize previousPage = _pPage;
@synthesize page = _page;
@synthesize max = _max;
@synthesize min = _min;
@synthesize doNotDispathEvent;


//--------------------------------------------------------------//
#pragma mark -- Initialize --
//--------------------------------------------------------------//

- (id)initWithMinPage: (int) min andMax: (int) max {
	if (!isInitialized) {
		CFUUIDRef uuid;
		uuid = CFUUIDCreate(NULL);
		_identifier = (NSString *)CFUUIDCreateString(NULL, uuid);
		CFRelease(uuid);

		self.CHANGED = [@"VWSTEPPER_CHANGED" stringByAppendingString: _identifier];
		self.NEXT = [@"VWSTEPPER_NEXT" stringByAppendingString: _identifier];
		self.PREV = [@"VWSTEPPER_PREV" stringByAppendingString: _identifier];
		self.IS_MAX = [@"VWSTEPPER_IS_MAX" stringByAppendingString: _identifier];
		self.IS_MIN = [@"VWSTEPPER_IS_MIN" stringByAppendingString: _identifier];

		isInitialized = YES;
		self.doNotDispathEvent = NO;
	}

	if (self = [super init]) {
		self.min = min;
		self.max = max;
		self.page = min;
	}

	return self;
}

- (id)init {
	return [self initWithMinPage: 0 andMax: 1];
}

- (void)dealloc {
	[_CHANGED release], _CHANGED = nil;
	[_IS_MAX release], _IS_MAX = nil;
	[_IS_MIN release], _IS_MIN = nil;

	_page = 0;

	[delegate release],     delegate = nil;

	[super dealloc];
}

-(void)resetWithMinPage:(int)min andMax:(int)max{
	self.min = min;
	self.max = max;
	self.page = min;
}

//--------------------------------------------------------------//
#pragma mark --public function --
//--------------------------------------------------------------//

- (void)next {
	[self changeTo: (_page + 1)];
}

- (void)prev {
	[self changeTo: (_page - 1)];
}

- (void)jumpTo: (int) newPage {
	[self changeTo: newPage];
}

//--------------------------------------------------------------//
#pragma mark -- private function --
//--------------------------------------------------------------//

- (void)changeTo: (int) newPage {
	_pPage = _page;
	_page = [self validateTo: newPage];
	[self update];
	if (_pPage < _page) {
		[delegate stepperPageNext: self];
		if (!self.doNotDispathEvent) [[NSNotificationCenter defaultCenter] postNotificationName: self.NEXT object: self];
	}
	if (_page < _pPage) {
		[delegate stepperPageprev: self];
		if (!self.doNotDispathEvent) [[NSNotificationCenter defaultCenter] postNotificationName: self.PREV object: self];
	}
}

- (void)update {
	if (_pPage != _page) {
		[delegate stepperPageChanged: self];
		if (!self.doNotDispathEvent) [[NSNotificationCenter defaultCenter] postNotificationName: self.CHANGED object: self];
	}
}

- (void)forceUpdate {
	[delegate stepperPageChanged: self];
	if (!self.doNotDispathEvent) [[NSNotificationCenter defaultCenter] postNotificationName: self.CHANGED object: self];
}

- (int)validateTo: (int) newPage {
	BOOL isMax = (BOOL)(_max < newPage);
	BOOL isMin = (BOOL)(newPage < _min);
	int result = newPage;

	if (isMax) {
		result = _max;
		[delegate stepperPageMax: self];
		if (!self.doNotDispathEvent) [[NSNotificationCenter defaultCenter] postNotificationName: self.IS_MAX object: self];
	}
	if (isMin) {
		result = _min;
		[delegate stepperPageMin: self];
		if (!self.doNotDispathEvent) [[NSNotificationCenter defaultCenter] postNotificationName: self.IS_MIN object: self];
	}

	return result;
}

@end