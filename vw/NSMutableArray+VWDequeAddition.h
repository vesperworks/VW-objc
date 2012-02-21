//
//  NSMutableArray+VWDequeAddition.h
//
//  Created by vesperworks on 11/10/18.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (VWDequeAddition)

- (id)pop;
- (id)shift;

- (void)push: (id) obj;
- (void)unshift: (id) obj;

@end