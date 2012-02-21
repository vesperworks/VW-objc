//
//  VWFileManager.m
//
//  Created by vesperworks on 11/09/01.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import "VWFileManager.h"

@implementation VWFileManager


#pragma mark initialize


static VWFileManager *  _sharedInstance = nil;

+ (VWFileManager *)sharedInstance {
	if (!_sharedInstance) {
		_sharedInstance = [[VWFileManager alloc] init];
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

#pragma mark private methods

- (NSString *)_dir {
	NSArray *paths;
	NSString *path;
	paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([paths count] < 1) {
		return nil;
	}
	path = [paths objectAtIndex: 0];
	path = [path stringByAppendingPathComponent: @".appsData"];

	return path;
}

- (NSString *)_pathWithName: (NSString *) name {
	NSString *path;
	path = [[self _dir] stringByAppendingPathComponent: name];
	return path;
}

#pragma mark methods

- (id)loadWithDatName: (NSString *) datName {
	NSString *dir;
	dir = [self _dir];
	if (!dir || ![[NSFileManager defaultManager] fileExistsAtPath: dir]) {
		return nil;
	}

	NSString *path;
	path = [self _pathWithName: datName];

	id data = [NSKeyedUnarchiver unarchiveObjectWithFile: path];
	if (!data) {
		return nil;
	}

	return data;
}

- (void)saveWithDatName: (NSString *) datName andData: (id) data {
	NSFileManager *fileMgr;
	fileMgr = [NSFileManager defaultManager];

	NSString *dir;
	dir = [self _dir];
	if (![fileMgr fileExistsAtPath: dir]) {
		NSError *error;
		[fileMgr createDirectoryAtPath: dir withIntermediateDirectories: YES attributes: nil error: &error];
	}

	NSString *path;
	path = [self _pathWithName: datName];

	[NSKeyedArchiver archiveRootObject: data toFile: path];
}

-(void)removeWithDatName:(NSString *)datName{
	NSString *dir;
	dir = [self _dir];
	if (!dir || ![[NSFileManager defaultManager] fileExistsAtPath: dir]) {
		return;
	}
	NSString *path;
	path = [self _pathWithName: datName];

	NSError *error;
	[[NSFileManager defaultManager] removeItemAtPath: path error: &error];
}

- (BOOL)isExistFileWithDatName: (NSString *) datName {
	NSString *dir;
	BOOL result = YES;
	dir = [self _dir];
	NSString *path;
	path = [self _pathWithName: datName];
	if (!dir || ![[NSFileManager defaultManager] fileExistsAtPath: path]) {
		result = NO;
	}
	return result;
}

@end