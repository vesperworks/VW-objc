//
//  VWUrlConectOperation.h
//
//  Created by vesperworks on 11/11/02.
//  Copyright (c) 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VWUrlConectOperation : NSOperation {
	NSMutableData *responseData;
	NSURLConnection *connection;
	BOOL _isExecuting, _isFinished, _isCancelled;
}
- (id)initWithURL: (NSString *) targetUrl;

@property (nonatomic, retain) NSMutableData *response;
@property (nonatomic, retain) NSString *url;
@end