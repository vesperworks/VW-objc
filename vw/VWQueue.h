//
//  VWQueue.h
//
//  Created by vesperworks on 11/10/17.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWQueue : NSObject {
	NSMutableArray *_queue;
	int _maxSize;
	int _count;
}

@property (nonatomic, readonly) int count;
@property (nonatomic, readonly) NSArray *queue;

- (id)initWithSize: (int) maxSize;
- (id)dequeue;
- (void)enqueue: (id) anObject;

@end