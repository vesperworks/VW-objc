//
//  VWQueueImageView.h
//
//  Created by vesperworks on 11/10/25.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWQueueImageView : UIImageView {
	@private

	UIActivityIndicatorView *refreshSpinner; 
}

+ (NSOperationQueue *)sharedImgOperationQueue;
+ (NSCache *)sharedImgCache;

- (void)loadImageURL: (NSString *) url withCollor: (UIColor *) color;

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSString *latestURL;

@end